//
//  HomeView.swift
//  Home
//
//  Created by 김남수 on 25/06/14.
//

import SwiftUI

import HGCommon
import HGDesignSystem

struct HomeView: View {
    @State var selected: StatusTab = .scheduled
    @State var category: ReservationCategoryType? = .restaurant
    let isShowSubReservationCardList: Bool = true
    let withReservation: Bool = false
    
    private let contentMinHight: CGFloat = UIScreen.main.bounds.height - UIConstant.tabBarHeight
    + UIWindow.safeAreaInsets.bottom - 38
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: UIWindow.safeAreaInsets.top)
                
                headerView
                    .padding(.horizontal, 16)
                
                if withReservation {
                    HomeViewWithReservation(
                        isShowSubReservationCardList: isShowSubReservationCardList
                    )
                } else {
                    HomeViewWithoutReservation()
                }
            }
            .frame(minHeight: contentMinHight)
            .background(alignment: .top) {
                backgorund
            }
        }
        .applyTabbarHeight(padding: 38)
        .ignoresSafeArea()
    }
    
    var headerView: some View {
        HStack(spacing: 0) {
            //TODO: 무엇인가 추가될 예정
            Spacer()
                .frame(width: 24)
            
            Spacer()
            
            StatusToggle(selected: $selected)
                .frame(width: 154, height: 40)
            
            Spacer()
            
            Button {
                
            } label: {
                HGIcons.bell.image
                    .foregroundStyle(.opacityBlack30)
            }
        }
        .padding(.vertical, 6)
    }
    
    var backgorund: some View {
        VStack(spacing: 0) {
            backgroundGradient
                .overlay(alignment: .top) {
                    if withReservation {
                        HGImages.restaurant.image
                            .offset(y: UIScreen.main.bounds.height * 0.18)
                    }
                }
            
            HGColors.gray10.color
                .frame(maxHeight: .infinity)
        }
        .ignoresSafeArea()
    }
    
    var backgroundGradient: some View {
        Group {
            if let category = category {
                // ContentHeight - 40(하단 패딩) - 91(카드뷰 height 절반)
                let height = contentMinHight - 40 - 91
                category.gradient
                    .frame(height: isShowSubReservationCardList ? 573 : height)
            } else {
                HGGradient.orangeSub
                    .frame(height: 564)
            }
        }
    }
}

private struct HomeViewWithoutReservation: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 40)
            
            NoReservationCard()
        }
        .fillMaxHeight(.top)
    }
}

private struct HomeViewWithReservation: View {
    @State var category: ReservationCategoryType? = .restaurant
    let isShowSubReservationCardList: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: isShowSubReservationCardList ? 50 : 52)
            
            Text("가장 가까운 예약까지")
                .setTypo(.title_20_bold)
                .foregroundStyle(.gray0White)
                .shadow(color: category?.darkColor ?? HGColors.orangeDark.color, radius: 20)
            
            Spacer()
                .frame(height: isShowSubReservationCardList ? 20 : 100)
            
            ReservationTimerView(category: .restaurant)
            
            Spacer()
                .frame(minHeight: 62)
            
            MainReservationCard(
                category: category ?? .restaurant,
                title: "매쉬업 야구 직관 모임",
                date: Date(),
                images: []
            )
            .padding(.horizontal, 16)
            
            Spacer()
                .frame(height: 40)
            
            if isShowSubReservationCardList  {
                subReservationCardList()
            }
        }
        .fillMaxHeight(.top)
    }
}

enum StatusTab {
    case scheduled
    case completed
}

private struct StatusToggle: View {
    @Binding var selected: StatusTab

    var body: some View {
        HStack(spacing: 0) {
            Button {
                selected = .scheduled
            } label: {
                Text("예정")
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.gray90)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        if selected == .scheduled {
                            Capsule()
                                .foregroundStyle(HGColors.gray0White)
                                .padding([.vertical, .leading], 4)
                        }
                    }
            }

            Button {
                selected = .completed
            } label: {
                Text("완료")
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.gray90)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        if selected == .completed {
                            Capsule()
                                .foregroundStyle(HGColors.gray0White)
                                .padding([.vertical, .trailing], 4)
                        }
                    }
            }
        }
        .background(.opacityBlack10)
        .clipShape(Capsule())
    }
}

private struct ReservationTimerView: View {
    let category: ReservationCategoryType
    
    var body: some View {
        HStack(spacing: 18) {
            TimerView(
                time: "10",
                description: "시간",
                backgroundColor: HGColors.opacityPink4.color
            )
            
            TimerView(
                time: "30",
                description: "분",
                backgroundColor: HGColors.opacityPink4.color
            )
            
            TimerView(
                time: "15",
                description: "초",
                backgroundColor: HGColors.opacityPink4.color
            )
        }
    }
}

#Preview(traits: .applyFont) {
    HomeView()
}
