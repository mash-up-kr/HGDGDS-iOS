//
//  OnboardingSlidesView.swift
//  OnboardingFeature
//
//  Created by iOS신상우 on 6/21/25.
//

import SwiftUI
import HGDesignSystem

struct OnboardingSlidesView: View {
    @Environment(OnboardingCoordinator.self) private var coordinator
    @State private var currentTab: OnboardingType = .first
    
    var body: some View {
        VStack(spacing: .zero) {
            pageControlArea
            slideArea
            bottomArea
        }
        .fillMaxSize()
        .background(.white)
        .ignoresSafeArea(.container, edges: [.bottom])
    }
    
    private var pageControlArea: some View {
        HGPageControl(
            numberOfPages: OnboardingType.allCases.count,
            currentIndex: Binding(
                get: { currentTab.rawValue },
                set: { _ in }
            )
        )
        .padding(.top, 34)
    }
    
    private var slideArea: some View {
        TabView(selection: $currentTab) {
            ForEach(OnboardingType.allCases, id: \.hashValue) { tab in
                VStack(spacing: .zero) {
                    Text(tab.title)
                        .multilineTextAlignment(.center)
                        .setTypo(.display_32_extraBold)
                        .foregroundStyle(.gray95)
                        .padding(.bottom, 6)
                    Text(tab.content)
                        .setTypo(.body_16_medium)
                        .foregroundStyle(.gray50)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 19)
                    tab.image.image
                        .fillMaxSize(.center)
                        .ignoresSafeArea()
                }
                .tag(tab)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .padding(.top, 34)
        
    }
    
    private var bottomArea: some View {
        HGButton(
            title: currentTab.bottomTitle,
            size: .xLarge,
            variant: .primary,
            isMaxWidth: true)
        {
            if currentTab == .third {
                coordinator.push(.enterNickname)
            } else {
                withAnimation {
                    currentTab = OnboardingType(rawValue: currentTab.rawValue+1) ?? .third
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 32)
        .frame(height: 132, alignment: .top)
    }
    
    enum OnboardingType: Int, CaseIterable {
        case first
        case second
        case third
        
        var title: String {
            switch self {
            case .first:
                return "흩어진 예약 정보\n한눈에 정리"
            case .second:
                return "예약 30분 전\n잊지 않도록 알림"
            case .third:
                return "친구들에게\n놓치지 말라고 콕!"
            }
        }
        
        var content: String {
            switch self {
            case .first:
                return "날짜부터 링크, 위치까지\n예약 정보를 보기 좋에 모아드려요"
            case .second:
                return "푸시와 진동 알림으로\n놓치지 않도록 미리 챙겨드려요"
            case .third:
                return "친구들에게 예약을 잊지 말라고\n콕 찔러 알림을 보내보세요"
            }
        }
        
        var bottomTitle: String {
            switch self {
            case .first, .second:
                return "다음"
            case .third:
                return "콕콕 시작하기"
            }
        }
        
        var image: HGImages {
            switch self {
            case .first: .onboardingFirst
            case .second: .onboardingSecond
            case .third: .onboardingThird
            }
        }
    }
}
