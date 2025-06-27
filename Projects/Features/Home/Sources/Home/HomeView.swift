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
    @State var reservationInfos: [ReservationCategoryType] = [.restaurant, .sports, .activity, .concert, .etc]
    @State var selectedReservationIndex: Int = 0
    
    let isShowSubReservationCardList: Bool = true
    let withReservation: Bool = true
    let isExistCompleteReservation: Bool = true
    
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    private var backgroundGradientHeight: CGFloat {
        // ContentHeight - 40(하단 패딩) - 91(카드뷰 height 절반)
        let minHeight = screenHeight - UIConstant.tabBarHeight
        return isShowSubReservationCardList ? 573 : minHeight - 40 - 91
    }
    
    var body: some View {
        ZStack {
            HGColors.gray10.color
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: UIWindow.safeAreaInsets.top + 52)
                    
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
                HomeMainReservationTabView(
                    selectedTabIndex: $selectedReservationIndex,
                    reservationInfos: reservationInfos,
                    isShowSubReservationCardList: isShowSubReservationCardList
                )
                
                if isShowSubReservationCardList  {
                    HomeSubReservationCardListView(title: "예정된 예약")
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
            HomeSubReservationCardListView(title: "완료된 예약")
                .padding(.top, 20)
                .padding(.horizontal, 16)
        } else {
            NoCompletedReservationVIew()
        }
    }
    
    @ViewBuilder
    var backgorund: some View {
        Group {
            if selectedTab == .scheduled {
                backgroundGradient
                    .overlay(alignment: .top) {
                        if withReservation {
                            reservationInfos[selectedReservationIndex].image
                                .offset(y: screenHeight * 0.18)
                        }
                    }
            }
        }
        .ignoresSafeArea()
        .animation(.linear(duration: 0.35), value: selectedTab)
        .animation(.easeInOut(duration: 0.25), value: selectedReservationIndex)
    }
    
    @ViewBuilder
    var backgroundGradient: some View {
        if withReservation {
            reservationInfos[selectedReservationIndex].gradient
                .frame(height: backgroundGradientHeight)
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
            } else if selectedTab == .completed {
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

#Preview(traits: .applyFont) {
    HomeView()
}
