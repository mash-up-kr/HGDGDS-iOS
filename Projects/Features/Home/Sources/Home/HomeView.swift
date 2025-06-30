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
    
    var body: some View {
        ZStack(alignment: .top) {
            background
                .ignoresSafeArea()
            
            categoryImage

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
            }
        }
        .animation(.easeOut(duration: 0.35), value: viewModel.selectedStatusTab)
        .animation(.easeInOut(duration: 0.25), value: viewModel.selectedReservationIndex)
    }
    
    @ViewBuilder
    private var scheduledReservationView: some View {
        if viewModel.isExistScheduledMainReservation {
            VStack(spacing: 0) {
                HomeMainReservationTabView(viewModel: viewModel)
                
                if viewModel.isExistSchduledSubReservations {
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
    private  var completedReservationView: some View {
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
    private  var background: some View {
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
            viewModel.selectedMainReservationCategory?.gradient
                .frame(height: viewModel.backgroundGradientHeight)
        } else {
            HGGradient.orangeSub
                .frame(height: 564)
        }
    }
    
    private var categoryImage: some View {
        TransitionTabSwitcherView(selectedTab: viewModel.selectedStatusTab) {
            Group {
                if viewModel.isExistScheduledMainReservation {
                    viewModel.selectedMainReservationCategory?.image
                        .resizable()
                        .frame(354)
                        .offset(y: viewModel.screenHeight * 0.15)
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
    @Binding var selectedTab: ReservationStatusTab

    var body: some View {
        HStack(spacing: 0) {
            tabItem(type: .scheduled)
            
            tabItem(type: .completed)
        }
        .animation(.easeInOut, value: selectedTab)
        .background(.opacityBlack10)
        .clipShape(Capsule())
        .frame(width: 154, height: 40)
        .padding(.vertical, 6)
    }
    
    func tabItem(type: ReservationStatusTab) -> some View {
        Button {
            selectedTab = type
        } label: {
            Text(type.tabTitle)
                .setTypo(.body_14_bold)
                .foregroundStyle(.gray90)
                .fillMaxSize(.center)
                .background {
                    if selectedTab == type {
                        Capsule()
                            .foregroundStyle(HGColors.gray0White)
                            .padding([.vertical, .leading], 4)
                    }
                }
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
