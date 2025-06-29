//
//  HomeView.swift
//  Home
//
//  Created by 김남수 on 25/06/14.
//

import SwiftUI

import HGCommon
import HomeDomain
import HGDesignSystem

struct HomeView: View {
    @Bindable private var viewModel: HomeViewModel = .init()
    
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    private var backgroundGradientHeight: CGFloat {
        // ContentHeight - 52(하단 패딩) - 91(카드뷰 height 절반)
        let minHeight = screenHeight - UIConstant.tabBarHeight
        return viewModel.isExistSchduledSubReservations ? 573 : minHeight - 52 - 91
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            backgorund
                .ignoresSafeArea()
            
            categoryImage

            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: UIWindow.safeAreaInsets.top + 52)
                    
                    TransitionTabSwitcherView(selectedTab: viewModel.selectedStatusTab) {
                        scheduledReservationView
                    } completedView: {
                        completedReservationView
                    }
                    .padding(.bottom, 52)
                }
                .padding(.bottom, UIConstant.tabBarHeight)
                .fillMaxSize(.top)
                .overlay(alignment: .top) {
                    header
                        .padding(.top, UIWindow.safeAreaInsets.top)
                        .padding(.horizontal, 16)
                }
            }
            .ignoresSafeArea()
        }
        .animation(.easeOut(duration: 0.4), value: viewModel.selectedStatusTab)
        .animation(.easeInOut(duration: 0.25), value: viewModel.selectedReservationIndex)
    }
    
    @ViewBuilder
    var scheduledReservationView: some View {
        if viewModel.isExistScheduledMainReservation {
            VStack(spacing: 0) {
                HomeMainReservationTabView(viewModel: viewModel)
                
                if viewModel.isExistSchduledSubReservations  {
                    HomeSubReservationCardListView(
                        statusTab: .scheduled,
                        reservations: viewModel.scheduledReservationInfos
                    )
                    .padding(.horizontal, 16)
                }
            }
        } else {
            HomeEmptyReservationView()
        }
    }
    
    @ViewBuilder
    var completedReservationView: some View {
        if viewModel.isExistCompleteReservation {
            HomeSubReservationCardListView(
                statusTab: .scheduled,
                reservations: viewModel.completedReservationInfos
            )
            .padding(.top, 20)
            .padding(.horizontal, 16)
        } else {
            NoCompletedReservationVIew()
        }
    }
    
    @ViewBuilder
    var backgorund: some View {
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
    var backgroundGradient: some View {
        if viewModel.isExistScheduledMainReservation {
            viewModel.mainReservationInfos[safe: viewModel.selectedReservationIndex]?.category.gradient
                .frame(height: backgroundGradientHeight)
        } else {
            HGGradient.orangeSub
                .frame(height: 564)
        }
    }
    
    var categoryImage: some View {
        TransitionTabSwitcherView(selectedTab: viewModel.selectedStatusTab) {
            Group {
                if viewModel.isExistScheduledMainReservation {
                    viewModel.mainReservationInfos[safe: viewModel.selectedReservationIndex]?.category.image
                        .resizable()
                        .frame(354)
                        .offset(y: screenHeight * 0.15)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }
            }
        } completedView: {
            Color.clear
                .transition(.move(edge: .trailing).combined(with: .opacity))
        }
    }
    
    var header: some View {
        ReservationStatusToggle(selectedTab: $viewModel.state.selectedStatusTab)
            .frame(width: 154, height: 40)
            .padding(.vertical, 6)
    }
}

struct TransitionTabSwitcherView<FirstView: View, SecondView: View>: View {
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

struct ReservationStatusToggle: View {
    @Binding var selectedTab: ReservationStatusTab

    var body: some View {
        HStack(spacing: 0) {
            Button {
                selectedTab = .scheduled
            } label: {
                Text("예정")
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.gray90)
                    .fillMaxSize(.center)
                    .background {
                        if selectedTab == .scheduled {
                            Capsule()
                                .foregroundStyle(HGColors.gray0White)
                                .padding([.vertical, .leading], 4)
                        }
                    }
            }

            Button {
                selectedTab = .completed
            } label: {
                Text("완료")
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.gray90)
                    .fillMaxSize(.center)
                    .background {
                        if selectedTab == .completed {
                            Capsule()
                                .foregroundStyle(HGColors.gray0White)
                                .padding([.vertical, .trailing], 4)
                        }
                    }
            }
        }
        .animation(.easeInOut, value: selectedTab)
        .background(.opacityBlack10)
        .clipShape(Capsule())
        .frame(width: 154, height: 40)
        .padding(.vertical, 6)
    }
}

#Preview(traits: .applyFont) {
    HomeView()
}
