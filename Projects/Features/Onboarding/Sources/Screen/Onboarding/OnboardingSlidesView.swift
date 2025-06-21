//
//  OnboardingSlidesView.swift
//  OnboardingFeature
//
//  Created by iOS신상우 on 6/21/25.
//

import SwiftUI
import HGDesignSystem

struct OnboardingSlidesView: View {
    @State var currentTab: OnboardingType = .first
    
    var body: some View {
        VStack(spacing: .zero) {
            pageControlArea
            slideArea
            bottomArea
        }
        .fillMaxSize()
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
                        .padding(.bottom, 6)
                    Text(tab.content)
                        .setTypo(.body_16_medium)
                        .foregroundStyle(.gray50)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 19)
                    HGColors.gray10.color
                        .fillMaxSize(.center)
                        .ignoresSafeArea()
                        .overlay {
                            Text("이미지 영역")
                        }
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
            if currentTab == .thrid {
                // TODO: 프로필
            } else {
                withAnimation {
                    currentTab = OnboardingType(rawValue: currentTab.rawValue+1) ?? .thrid
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
        case thrid
        
        var title: String {
            switch self {
            case .first:
                return "흩어진 예약 정보\n한눈에 정리"
            case .second:
                return "예약 30분 전\n잊지 않도록 알림"
            case .thrid:
                return "친구들에게\n놓치지 말라고 콕!"
            }
        }
        
        var content: String {
            switch self {
            case .first:
                return "날짜부터 링크, 위치까지\n예약 정보를 보기 좋에 모아드려요"
            case .second:
                return "푸시와 진동 알림으로\n놓치지 않도록 미리 챙겨드려요"
            case .thrid:
                return "친구들에게 예약을 잊지 말라고\n콕 찔러 알림을 보내보세요"
            }
        }
        
        var bottomTitle: String {
            switch self {
            case .first, .second:
                return "다음"
            case .thrid:
                return "콕콕 시작하기"
            }
        }
    }
}

#Preview {
    UIFont.registerAllFont()
    return OnboardingSlidesView()
}
