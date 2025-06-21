//
//  OnboardingMainView.swift
//  OnboardingFeature
//
//  Created by Enes on 6/14/25.
//

import SwiftUI
import HGDesignSystem

struct OnboardingMainView: View {
    @Environment(OnboardingCoordinator.self) var coordinator
    
    var body: some View {
        VStack(spacing: .zero) {
            imageArea
            logoArea
            bottomArea
        }
        .fillMaxSize(.center)
        .ignoresSafeArea()
    }
    
    private var imageArea: some View {
        HGColors.gray10.color
            .fillMaxSize(.center)
            .ignoresSafeArea()
            .overlay {
                Text("이미지 영역")
            }
    }
    
    private var logoArea: some View {
        VStack(spacing: 25) {
            Text("로고 영역")
                .setTypo(.display_40_extraBold)
            Text("함께하는 즐거운 예약을\n지금 시작하세요!")
                .setTypo(.heading_24_bold)
                .foregroundStyle(.gray100Black)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 24.54)
    }
    
    private var bottomArea: some View {
        HGButton(
            title: "시작하기",
            size: .xLarge,
            variant: .primary,
            isMaxWidth: true)
        {
            coordinator.push(.onboardingSlide)
        }
        .padding(.horizontal, 16)
        .frame(height: 132)
    }
}

#Preview {
    OnboardingCoordinatorView()
}
