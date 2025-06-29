//
//  HomeMainReservationTabView.swift
//  HomeFeature
//
//  Created by 박병호 on 6/28/25.
//

import SwiftUI

import HomeDomain
import HGCommon
import HGDesignSystem

struct HomeMainReservationTabView: View {
    @Bindable var viewModel: HomeViewModel
    
    private let tabbarHeight: CGFloat = UIConstant.tabBarHeight
    private let headerHeight: CGFloat = UIWindow.safeAreaInsets.top + 52
    private let tabViewHeight: CGFloat = 489
    
    var body: some View {
        TabView(selection: $viewModel.state.selectedReservationIndex) {
            ForEach(viewModel.mainReservationInfos, id: \.reservationId) { info in
                MainReservationView(
                    reservationInfo: info,
                    isShowSubReservationCardList: viewModel.isExistSchduledSubReservations
                ) {
                    
                }
                .tag(info.reservationId)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: viewModel.isExistSchduledSubReservations ? tabViewHeight
               : UIScreen.main.bounds.height - tabbarHeight - headerHeight)
        .overlay(alignment: .bottom) {
            if viewModel.mainReservationInfos.count > 1 {
                indicator
            }
        }
        .animation(.easeInOut(duration: 0.25), value: viewModel.selectedReservationIndex)
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
    let action: () -> Void
    
    @State private var countDownTimer: CountDownTimerManager = .init()
    
    var dDay: Int {
        Date().dDayValue(from: reservationInfo.reservationDatetime)
    }
    
    init(reservationInfo: ReservationInfo, isShowSubReservationCardList: Bool, action: @escaping () -> Void) {
        self.reservationInfo = reservationInfo
        self.isShowSubReservationCardList = isShowSubReservationCardList
        self.action = action
        
        countDownTimer.setupTime(endDate: reservationInfo.reservationDatetime)
        countDownTimer.start()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: isShowSubReservationCardList ? 20 : 44)
            
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
                    hours: countDownTimer.hours,
                    minutes: countDownTimer.minutes,
                    seconds: countDownTimer.seconds
                )
            }
            
            Spacer().frame(minHeight: 33)
            
            MainReservationCard(reservationInfo: reservationInfo) {
                action()
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 52)
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
                backgroundColor: category.opcityColor.color
            )
            
            TimerView(
                time: minutes,
                description: "분",
                backgroundColor: category.opcityColor.color
            )
            
            TimerView(
                time: seconds,
                description: "초",
                backgroundColor: category.opcityColor.color
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
