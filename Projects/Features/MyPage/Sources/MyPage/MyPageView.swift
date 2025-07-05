//
//  MyPageView.swift
//  MyPage
//
//  Created by 김남수 on 25/06/14.
//

import SwiftUI
import HGDesignSystem

struct MyPageView: View {
    @Environment(MyPageCoordinator.self) var coordinator
    @Environment(HGTabViewManager.self) var tabManager
    @State private var viewModel: MyPageViewModel = .init()
    
    var body: some View {
        ZStack {
            viewModel.profileType.backgroundColor
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer().frame(height: 58)
                nicknameView
                Spacer()
                SuccessRateView(
                    allCount: viewModel.totalReservationCount,
                    successCount: viewModel.successReservationCount,
                    profileType: viewModel.profileType
                )
                .padding(.horizontal, 16)
            }
            .applyTabbarHeight(padding: 38)
            .fillMaxSize(.top)
            .overlay(alignment: .topTrailing) { settingButton }
        }
        .onAppear {
            tabManager.setTabBarHidden(false)
            viewModel.reduce(.onAppear)
        }
    }
    
    private var settingButton: some View {
        Button {
            coordinator.push(.setting)
        } label: {
            HGIcons.setting.image
                .resizable()
                .frame(28)
                .foregroundStyle(.opacityWhite60)
                .padding(.trailing, 16)
        }
    }
    
    private var nicknameView: some View {
        Text(viewModel.nickname)
            .setTypo(.title_20_bold)
            .foregroundStyle(.gray0White)
            .frame(height: 53)
            .padding(.horizontal, 32)
            .background(.white.opacity(0.1))
            .background(.ultraThinMaterial)
            .strokeBorder(HGColors.opacityWhite10.color, radius: 27, linewidth: 2)
    }
}


#Preview(traits: .applyFont) {
    MyPageView()
}
