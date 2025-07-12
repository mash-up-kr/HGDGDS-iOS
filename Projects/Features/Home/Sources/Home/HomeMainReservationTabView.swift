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

    var body: some View {
        VStack(spacing: 0) {
            headerText
                .background(alignment: .top) {
                    categoryImage
                }
            if isShowSubReservationCardList {
                Spacer().frame(height: 42)
            } else {
                Spacer().frame(maxHeight: 70)
            }
            
            ReservationTimerView(reservationInfo: reservationInfo)
            
            Spacer().frame(minHeight: 33)
            
            MainReservationCard(reservationInfo: reservationInfo) {
                action()
            }
        }
        .padding(.top, isShowSubReservationCardList ? 20 : 44)
        .padding(.horizontal, 16)
        
    }
    
    private var headerText: some View {
        Text("가장 가까운 예약까지")
            .setTypo(.body_16_medium)
            .foregroundStyle(.gray0White)
            .shadow(color: reservationInfo.categoryType.darkColor.color, radius: 20)
    }
    
    @ViewBuilder
    private var categoryImage: some View {
        reservationInfo.categoryType.image
            .resizable()
            .frame(354)
            .transition(.move(edge: .leading).combined(with: .opacity))
    }
}

private struct ReservationTimerView: View {
    @State private var countDownTimer: CountDownTimerManager = .init()
    let category: ReservationCategoryType
    let endDate: Date
    let dDay: Int
    
    init(reservationInfo: ReservationInfo) {
        self.category = reservationInfo.categoryType
        self.endDate = reservationInfo.reservationDatetime
        self.dDay = reservationInfo.reservationDatetime.dDayValue()
    }
    
    var body: some View {
        VStack(spacing: 8) {
            dDayText
            
            HStack(spacing: 4) {
                TimerView(
                    time: countDownTimer.hours,
                    description: "시간",
                    backgroundColor: category.opacityColor.color
                )
                
                colon
                
                TimerView(
                    time: countDownTimer.minutes,
                    description: "분",
                    backgroundColor: category.opacityColor.color
                )
                
                colon
                
                TimerView(
                    time: countDownTimer.seconds,
                    description: "초",
                    backgroundColor: category.opacityColor.color
                )
            }
        }
        .onAppear {
            countDownTimer.setupTime(endDate: endDate)
            countDownTimer.start()
        }
        .onDisappear {
            countDownTimer.stop()
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
