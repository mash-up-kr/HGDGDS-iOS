//
//  HomeMainReservationTabView.swift
//  HomeFeature
//
//  Created by 박병호 on 6/28/25.
//

import SwiftUI

import HGDesignSystem

struct HomeMainReservationTabView: View {
    @Binding var selectedTabIndex: Int
    let reservationInfos: [ReservationCategoryType]
    let isShowSubReservationCardList: Bool
    
    private let tabbarHeight: CGFloat = UIConstant.tabBarHeight
    private let headerHeight: CGFloat = UIWindow.safeAreaInsets.top + 52
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            ForEach(Array(reservationInfos.enumerated()), id: \.offset) { index, info in
                MainReservationView(
                    category: info,
                    isShowSubReservationCardList: isShowSubReservationCardList
                )
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: isShowSubReservationCardList ? 477
               : UIScreen.main.bounds.height - tabbarHeight - headerHeight)
        .overlay(alignment: .bottom) {
            if reservationInfos.count > 1 {
                indicator
            }
        }
        .animation(.easeInOut(duration: 0.25), value: selectedTabIndex)
    }
    
    var indicator: some View {
        HStack(spacing: 4) {
            ForEach(0..<reservationInfos.count, id: \.self) { index in
                Circle()
                    .frame(6)
                    .foregroundStyle(
                        index == selectedTabIndex ? HGColors.orange500Main : HGColors.gray20
                    )
            }
        }
        .padding(.top, 12)
        .padding(.bottom, 22)
    }
}

private struct MainReservationView: View {
    let category: ReservationCategoryType
    let isShowSubReservationCardList: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: isShowSubReservationCardList ? 50 : 52)
            
            headerTextView
            
            Spacer().frame(height: isShowSubReservationCardList ? 20 : 100)
            
            ReservationTimerView(category: category)
            
            Spacer().frame(minHeight: 62)
            
            MainReservationCard(
                category: category,
                title: "매쉬업 야구 직관 모임",
                date: Date(),
                userImageURLStrings: [
                    // 임시 URL
                    "https://i.pravatar.cc/150?img=4",
                    "https://i.pravatar.cc/300",
                    "https://i.pravatar.cc/150?img=3",
                ]
            )
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 40)
    }
    
    var headerTextView: some View {
        Text("가장 가까운 예약까지")
            .setTypo(.title_20_bold)
            .foregroundStyle(.gray0White)
            .shadow(color: category.darkColor.color, radius: 20)
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
    @Previewable @State var selectedIndex = 0
    
    HomeMainReservationTabView(
        selectedTabIndex: $selectedIndex,
        reservationInfos: [.restaurant, .concert, .activity, .sports, .etc], // 예시 값
        isShowSubReservationCardList: true
    )
}
