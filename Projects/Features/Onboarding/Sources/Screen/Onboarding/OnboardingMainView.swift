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
        .background(.white)
        .ignoresSafeArea()
    }
    
    private var imageArea: some View {
        HGImages.onboardingMain.image
            .resizable()
            .fillMaxSize(.center)
            .ignoresSafeArea()
    }
    
    private var logoArea: some View {
        VStack(spacing: 25) {
            HGImages.kokkokLogo.image
                .foregroundStyle(.gray100Black)
            Text("함께하는 즐거운 예약을\n지금 시작하세요!")
                .setTypo(.heading_24_bold)
                .foregroundStyle(.gray100Black)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 25)
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

#Preview(traits: .applyFont) {
    OnboardingCoordinatorView()
}
