//
//  HomeView.swift
//  Home
//
//  Created by 김남수 on 25/06/14.
//

import SwiftUI

import HGCommon
import HomeDomain
import ReservationDomain
import HGDesignSystem

struct HomeView: View {
    @Environment(HGTabViewManager.self) var tabManager
    @Environment(HomeCoordinator.self) var coordinator
    @State private var viewModel: HomeViewModel = .init()
    
    private var backgroundGradientHeight: CGFloat {
        /// Screen height - TabBar height - Bottom padding - 91(카드뷰 height 절반)
        let noListGradientHeight = HomeUIConstans.screenHeight - UIConstant.tabBarHeight - HomeUIConstans.bottomPadding - 91
        return viewModel.isExistScheduledSubReservations ? 573 : noListGradientHeight
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            background
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    header
                    
                    TransitionTabSwitcherView(selectedTab: viewModel.selectedStatusTab) {
                        scheduledReservationView
                    } completedView: {
                        completedReservationView
                    }
                }
                .padding(.bottom, UIConstant.tabBarHeight)
                .fillMaxSize(.top)
                .background(alignment: .top) {
                    categoryImage
                }
            }
        }
        .animation(.easeOut(duration: 0.35), value: viewModel.selectedStatusTab)
        .animation(.easeInOut(duration: 0.25), value: viewModel.selectedReservationIndex)
        .onAppear {
            tabManager.setTabBarHidden(false)
            viewModel.reduce(.onAppear)
        }
        .onReceive(NotificationCenter.default.publisher(for: .createReservationComplete)) { _ in
            viewModel.reduce(.onAppear)
        }
    }
    
    @ViewBuilder
    private var scheduledReservationView: some View {
        if viewModel.isExistScheduledMainReservation {
            VStack(spacing: 0) {
                HomeMainReservationTabView(viewModel: viewModel)
                
                if viewModel.isExistScheduledSubReservations {
                    HomeSubReservationCardListView(
                        statusTab: .scheduled,
                        reservations: viewModel.scheduledReservationInfos,
                        totalCount: viewModel.scheduledPaginationMetadata.total,
                        mainReservationCount: viewModel.mainReservationInfos.count,
                        tapItemAction: { reservationId, category in
                            coordinator.push(.upcomingReservationDetail(reservationId: reservationId, category: category))
                        },
                        lastItemAction: {
                            viewModel.reduce(.loadMoreReservation(status: .after))
                        }
                    )
                    .padding(.horizontal, 16)
                }
            }
        } else {
            HomeEmptyReservationView()
                .frame(height: HomeUIConstans.contentHeight)
        }
    }
    
    @ViewBuilder
    private var completedReservationView: some View {
        if viewModel.isExistCompleteReservation {
            HomeSubReservationCardListView(
                statusTab: .completed,
                reservations: viewModel.completedReservationInfos,
                totalCount: viewModel.completedPaginationMetadata.total,
                tapItemAction: { reservationId, category in
                    coordinator.push(
                        .reservationHistory(
                            .resultShare(reservationID: reservationId, categoryRawValue: category.rawValue)
                        )
                    )
                },
                lastItemAction: {
                    viewModel.reduce(.loadMoreReservation(status: .before))
                }
            )
            .padding(.top, 20)
            .padding(.horizontal, 16)
        } else {
            NoCompletedReservationView()
                .frame(height: HomeUIConstans.contentHeight)
        }
    }
    
    @ViewBuilder
    private var background: some View {
        ZStack(alignment: .top) {
            if viewModel.selectedStatusTab == .scheduled {
                VStack(spacing: 0) {
                    backgroundGradient
                    
                    HGColors.gray10.color
                }
            }
        }
    }
    
    @ViewBuilder
    private var backgroundGradient: some View {
        if viewModel.isExistScheduledMainReservation {
            viewModel.mainReservationInfos[safe: viewModel.selectedReservationIndex]?.categoryType.gradient
                .frame(height: backgroundGradientHeight)
        } else {
            HGGradient.orangeSub
                .frame(height: 564)
        }
    }
    
    private var categoryImage: some View {
        TransitionTabSwitcherView(selectedTab: viewModel.selectedStatusTab) {
            Group {
                if viewModel.isExistScheduledMainReservation {
                    viewModel.mainReservationInfos[safe: viewModel.selectedReservationIndex]?.categoryType.image
                        .resizable()
                        .frame(354)
                        .offset(y: viewModel.isExistScheduledSubReservations ? 32 : 96)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }
            }
        } completedView: {
            Color.clear
                .transition(.move(edge: .trailing).combined(with: .opacity))
        }
    }
    
    private var header: some View {
        ReservationStatusToggle(selectedTab: $viewModel.state.selectedStatusTab)
            .frame(width: 154, height: 40)
            .padding(.vertical, 6)
    }
}

private struct ReservationStatusToggle: View {
    @Namespace var namespace
    @Binding var selectedTab: ReservationStatusTab

    var body: some View {
        HStack(spacing: 0) {
            tabItem(type: .scheduled)
            
            tabItem(type: .completed)
        }
        .background(.opacityBlack10)
        .clipShape(Capsule())
        .frame(width: 154, height: 40)
        .padding(.vertical, 6)
    }
    
    private func tabItem(type: ReservationStatusTab) -> some View {
        Button {
            selectedTab = type
        } label: {
            Text(type.tabTitle)
                .setTypo(.body_14_bold)
                .foregroundStyle(textColor(type: type))
                .fillMaxSize(.center)
                .background {
                    if selectedTab == type {
                        Capsule()
                            .foregroundStyle(HGColors.gray0White.color)
                            .padding([.vertical, type == .scheduled ? .leading : .trailing], 4)
                            .animation(.spring, value: selectedTab)
                            .matchedGeometryEffect(
                                id: "tabItem",
                                in: namespace.self
                            )
                    }
                }
        }
    }
    
    func textColor(type: ReservationStatusTab) -> HGColors {
        switch type {
        case .scheduled:
            selectedTab == .scheduled ? .gray90 : .gray40
        case .completed:
            selectedTab == .completed ? .gray90 : .gray0White
        }
    }
}

private struct TransitionTabSwitcherView<FirstView: View, SecondView: View>: View {
    let selectedTab: ReservationStatusTab
    let scheduledView: () -> FirstView
    let completedView: () -> SecondView

    var body: some View {
        ZStack {
            if selectedTab == .scheduled {
                scheduledView()
                    .transition(.move(edge: .leading).combined(with: .opacity))
            } else if selectedTab == .completed {
                completedView()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
    }
}

#Preview(traits: .applyFont) {
    HomeView()
}
