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
    @Bindable var viewModel: HomeViewModel
    
    var body: some View {
        TabView(selection: $viewModel.state.selectedReservationIndex) {
            ForEach(
                Array(viewModel.mainReservationInfos.enumerated()),
                id: \.offset
            ) { index, info in
                MainReservationView(
                    reservationInfo: info,
                    isShowSubReservationCardList: viewModel.isExistScheduledSubReservations,
                    countDownTimer: viewModel.state.timerManagers[safe: index]
                ) {
                    //TODO: 예약 상세 화면 이동
                }
                .padding(.bottom, viewModel.bottomPadding)
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: viewModel.mainReservationTabViewHeight)
        .overlay(alignment: .bottom) {
            if viewModel.mainReservationInfos.count > 1 {
                indicator
            }
        }
        .onAppear {
            viewModel.reduce(.setUpAllTimers)
        }
        .onDisappear {
            viewModel.reduce(.removeAllTimers)
        }
        .onChange(of: self.viewModel.selectedReservationIndex) { previousIndex, currentIndex in
            viewModel.reduce(.stopTimer(previousIndex))
            viewModel.reduce(.startTimer(currentIndex))
        }
    }
    
    var indicator: some View {
        HStack(spacing: 4) {
            ForEach(0..<viewModel.mainReservationInfos.count, id: \.self) { index in
                Circle()
                    .frame(6)
                    .foregroundStyle(
                        index == viewModel.selectedReservationIndex ? HGColors.orange500Main : HGColors.gray20
                    )
            }
        }
        .padding(.top, 12)
        .padding(.bottom, 34)
    }
}

private struct MainReservationView: View {
    let reservationInfo: ReservationInfo
    let isShowSubReservationCardList: Bool
    var countDownTimer: CountDownTimerManager?
    let action: () -> Void
    
    var dDay: Int {
        reservationInfo.reservationDatetime.dDayValue(from: Date())
    }

    var body: some View {
        VStack(spacing: 0) {
            headerText
            
            if isShowSubReservationCardList {
                Spacer().frame(height: 42)
            } else {
                Spacer().frame(maxHeight: 70)
            }
            
            VStack(spacing: 8) {
                dDayText
                
                ReservationTimerView(
                    category: reservationInfo.category,
                    hours: countDownTimer?.hours ?? "",
                    minutes: countDownTimer?.minutes ?? "",
                    seconds: countDownTimer?.seconds ?? ""
                )
            }
            
            Spacer().frame(minHeight: 33)
            
            MainReservationCard(reservationInfo: reservationInfo) {
                action()
            }
        }
        .padding(.top, isShowSubReservationCardList ? 20 : 44)
        .padding(.horizontal, 16)
    }
    
    var headerText: some View {
        Text("가장 가까운 예약까지")
            .setTypo(.title_20_bold)
            .foregroundStyle(.gray0White)
            .shadow(color: reservationInfo.category.darkColor.color, radius: 20)
    }
    
    var dDayText: some View {
        Text(dDay < 0 ? "D\(dDay)" : "D-DAY")
            .setTypo(.heading_24_bold)
            .foregroundStyle(.gray0White)
            .shadow(color: HGColors.opacityBlack60.color, radius: 15, y: 2)
    }
}

private struct ReservationTimerView: View {
    let category: ReservationCategoryType
    var hours: String
    var minutes: String
    var seconds: String
    
    var body: some View {
        HStack(spacing: 18) {
            TimerView(
                time: hours,
                description: "시간",
                backgroundColor: category.opacityColor.color
            )
            
            TimerView(
                time: minutes,
                description: "분",
                backgroundColor: category.opacityColor.color
            )
            
            TimerView(
                time: seconds,
                description: "초",
                backgroundColor: category.opacityColor.color
            )
        }
    }
}

#Preview {
    @Previewable @State var viewModel: HomeViewModel = .init()
    
    HomeMainReservationTabView(
        viewModel: viewModel
    )
}
