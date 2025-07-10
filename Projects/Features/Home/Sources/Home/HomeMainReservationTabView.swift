//
//  HomeMainReservationTabView.swift
//  HomeFeature
//
//  Created by 박병호 on 6/28/25.
//

import SwiftUI

import HomeDomain
import HGCommon
import ReservationDomain
import HGDesignSystem

struct HomeMainReservationTabView: View {
    @Environment(HGTabViewManager.self) var tabManager
    @Environment(HomeCoordinator.self) var coordinator
    @Bindable var viewModel: HomeViewModel
    
    private var mainReservationTabViewHeight: CGFloat {
        viewModel.isExistScheduledSubReservations ? HomeUIConstans.defaultTabViewHeight
        : HomeUIConstans.screenHeight - UIConstant.tabBarHeight - HomeUIConstans.headerHeight
    }
    
    var body: some View {
        TabView(selection: $viewModel.state.selectedReservationIndex) {
            ForEach(
                Array(viewModel.mainReservationInfos.enumerated()),
                id: \.offset
            ) { index, info in
                MainReservationView(
                    reservationInfo: info,
                    isShowSubReservationCardList: viewModel.isExistScheduledSubReservations
                ) {
                    tabManager.setTabBarHidden(true)
                    coordinator.push(.upcomingReservationDetail(reservationId: info.reservationId, category: info.categoryType))
                }
                .padding(.bottom, HomeUIConstans.bottomPadding)
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: mainReservationTabViewHeight)
        .overlay(alignment: .bottom) {
            if viewModel.mainReservationInfos.count > 1 {
                indicator
            }
        }
    }
    
    private var indicator: some View {
        HStack(spacing: 4) {
            ForEach(0..<viewModel.mainReservationInfos.count, id: \.self) { index in
                Circle()
                    .frame(6)
                    .foregroundStyle(index == viewModel.selectedReservationIndex
                                     ? HGColors.orange500Main : HGColors.gray20)
            }
        }
        .padding(.top, 12)
        .padding(.bottom, 34)
    }
}

private struct MainReservationView: View {
    let reservationInfo: ReservationInfo
    let isShowSubReservationCardList: Bool
    let action: () -> Void
    
    @State var countDownTimer: CountDownTimerManager = .init()
    
    var dDay: Int { reservationInfo.reservationDatetime.dDayValue() }

    var body: some View {
        VStack(spacing: 0) {
            headerText
            
            if isShowSubReservationCardList {
                Spacer().frame(height: 42)
            } else {
                Spacer().frame(maxHeight: 70)
            }
            
            ReservationTimerView(
                category: reservationInfo.categoryType,
                dDay: dDay,
                hours: countDownTimer.hours,
                minutes: countDownTimer.minutes,
                seconds: countDownTimer.seconds
            )
            
            Spacer().frame(minHeight: 33)
            
            MainReservationCard(reservationInfo: reservationInfo) {
                action()
            }
        }
        .padding(.top, isShowSubReservationCardList ? 20 : 44)
        .padding(.horizontal, 16)
        .onAppear {
            countDownTimer.setupTime(endDate: reservationInfo.reservationDatetime)
            countDownTimer.start()
        }
        .onDisappear {
            countDownTimer.stop()
        }
    }
    
    private var headerText: some View {
        Text("가장 가까운 예약까지")
            .setTypo(.body_16_medium)
            .foregroundStyle(.gray0White)
            .shadow(color: reservationInfo.categoryType.darkColor.color, radius: 20)
    }
}

private struct ReservationTimerView: View {
    let category: ReservationCategoryType
    var dDay: Int
    var hours: String
    var minutes: String
    var seconds: String
    
    var body: some View {
        VStack(spacing: 8) {
            dDayText
            
            HStack(spacing: 4) {
                TimerView(
                    time: hours,
                    description: "시간",
                    backgroundColor: category.opacityColor.color
                )
                
                colon
                
                TimerView(
                    time: minutes,
                    description: "분",
                    backgroundColor: category.opacityColor.color
                )
                
                colon
                
                TimerView(
                    time: seconds,
                    description: "초",
                    backgroundColor: category.opacityColor.color
                )
            }
        }
    }
    
    private var dDayText: some View {
        Text(dDay > 0 ? "D-\(dDay)" : "D-DAY")
            .setTypo(.heading_24_bold)
            .foregroundStyle(.gray0White)
            .shadow(color: HGColors.opacityBlack60.color, radius: 15, y: 2)
    }
    
    private var colon: some View {
        Text(":")
            .setTypo(.display_32_extraBold)
            .foregroundStyle(.opacityWhite60)
    }
}

#Preview {
    @Previewable @State var viewModel: HomeViewModel = .init()
    
    HomeMainReservationTabView(
        viewModel: viewModel
    )
}
