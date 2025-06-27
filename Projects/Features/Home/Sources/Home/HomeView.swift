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
    @State var selectedTab: ReservationStatusTab = .scheduled
    @State var reservationInfos: [ReservationCategoryType] = [.restaurant, .sports, .activity, .concert,
                                                              .etc]
    
    let isShowSubReservationCardList: Bool = true
    let withReservation: Bool = true
    let isExistCompleteReservation: Bool = false
    
    @State var selectedReservationIndex: Int = 0

    var body: some View {
        ZStack {
            HGColors.gray10.color
            
            ScrollView {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: UIWindow.safeAreaInsets.top + 52)
                    
                    TransitionTabSwitcherView(selectedTab: selectedTab) {
                        scheduledReservationView
                    } completedView: {
                        completedReservationView
                    }
                    .padding(.bottom ,40)
                }
                .padding(.bottom, UIConstant.tabBarHeight)
                .fillMaxSize(.top)
                .background(alignment: .top) {
                    backgorund
                }
                .overlay(alignment: .top) {
                    header
                        .padding(.top, UIWindow.safeAreaInsets.top)
                        .padding(.horizontal, 16)
                }
            }
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    var scheduledReservationView: some View {
        if withReservation {
            VStack(spacing: 0) {
                HomeReservationView(
                    selectedTabIndex: $selectedReservationIndex,
                    reservationInfos: reservationInfos,
                    isShowSubReservationCardList: isShowSubReservationCardList
                )
                
                if isShowSubReservationCardList  {
                    subReservationCardListView(title: "예정된 예약")
                        .padding(.horizontal, 16)
                }
            }
        } else {
            HomeEmptyReservationView()
        }
    }
    
    @ViewBuilder
    var completedReservationView: some View {
        if isExistCompleteReservation {
            subReservationCardListView(title: "완료된 예약")
                .padding(.top, 20)
                .padding(.horizontal, 16)
        } else {
            NoCompletedReservationVIew()
        }
    }
    
    var backgorund: some View {
        VStack(spacing: 0) {
            if selectedTab == .scheduled {
                backgroundGradient
                    .overlay(alignment: .top) {
                        if withReservation {
                            reservationInfos[selectedReservationIndex].image
                                .offset(y: UIScreen.main.bounds.height * 0.18)
                        }
                    }
            }
        }
        .ignoresSafeArea()
        .animation(.easeIn(duration: 0.4), value: selectedTab)
        .animation(.easeInOut(duration: 0.25), value: selectedReservationIndex)
    }
    
    @ViewBuilder
    var backgroundGradient: some View {
        // ContentHeight - 40(하단 패딩) - 91(카드뷰 height 절반)
        let contentMinHight: CGFloat = UIScreen.main.bounds.height - UIConstant.tabBarHeight
        let height = contentMinHight - 40 - 91
        
        if withReservation {
            reservationInfos[selectedReservationIndex].gradient
                .frame(height: isShowSubReservationCardList ? 573 : height)
        } else {
            HGGradient.orangeSub
                .frame(height: 564)
        }
    }
    
    var header: some View {
        ReservationStatusToggle(selectedTab: $selectedTab)
            .frame(width: 154, height: 40)
            .padding(.vertical, 6)
        
    }
}

private struct HomeEmptyReservationView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 40)
            
            NoReservationCard()
        }
        .fillMaxHeight(.top)
    }
}

private struct HomeReservationView: View {
    @Binding var selectedTabIndex: Int
    let reservationInfos: [ReservationCategoryType]
    let isShowSubReservationCardList: Bool
    
    private let tabbarHeight: CGFloat = UIConstant.tabBarHeight
    private let herderHeight: CGFloat = UIWindow.safeAreaInsets.top + 52
    
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
               : UIScreen.main.bounds.height - tabbarHeight - herderHeight)
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
                    .foregroundStyle(
                        index == selectedTabIndex ? HGColors.orange500Main : HGColors.gray20
                    )
                    .frame(6)
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
            Spacer()
                .frame(height: isShowSubReservationCardList ? 50 : 52)
            
            Text("가장 가까운 예약까지")
                .setTypo(.title_20_bold)
                .foregroundStyle(.gray0White)
                .shadow(color: category.darkColor, radius: 20)
            
            Spacer()
                .frame(height: isShowSubReservationCardList ? 20 : 100)
            
            ReservationTimerView(category: category)
            
            Spacer()
                .frame(minHeight: 62)
            
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
}

enum ReservationStatusTab: Equatable {
    case scheduled
    case completed
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
            }

            if selectedTab == .completed {
                completedView()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(.easeIn(duration: 0.35), value: selectedTab)
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
