//
//  HomeMainReservationTabView.swift
//  HomeFeature
//
//  Created by 박병호 on 6/28/25.
//

import SwiftUI

import HomeDomain
import HGDesignSystem

struct HomeMainReservationTabView: View {
    @Bindable var viewModel: HomeViewModel
    
    private let tabbarHeight: CGFloat = UIConstant.tabBarHeight
    private let headerHeight: CGFloat = UIWindow.safeAreaInsets.top + 52
    
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
        .frame(height: viewModel.isExistSchduledSubReservations ? 477
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
        .padding(.bottom, 22)
    }
}

private struct MainReservationView: View {
    let reservationInfo: ReservationInfo
    let isShowSubReservationCardList: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: isShowSubReservationCardList ? 50 : 52)
            
            headerTextView
            
            Spacer().frame(height: isShowSubReservationCardList ? 20 : 100)
            
            ReservationTimerView(category: reservationInfo.category)
            
            Spacer().frame(minHeight: 62)
            
            MainReservationCard(reservationInfo: reservationInfo) {
                action()
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 40)
    }
    
    var headerTextView: some View {
        Text("가장 가까운 예약까지")
            .setTypo(.title_20_bold)
            .foregroundStyle(.gray0White)
            .shadow(color: reservationInfo.category.darkColor.color, radius: 20)
    }
}

private struct ReservationTimerView: View {
    let category: ReservationCategoryType
    
    var body: some View {
        HStack(spacing: 18) {
            TimerView(
                time: "10",
                description: "시간",
                backgroundColor: category.opcityColor.color
            )
            
            TimerView(
                time: "30",
                description: "분",
                backgroundColor: category.opcityColor.color
            )
            
            TimerView(
                time: "15",
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
