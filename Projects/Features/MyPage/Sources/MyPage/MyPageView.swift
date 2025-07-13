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
    
    // 디자인상 프로필이미지가 무조건 가려져야해서
    // 이미지가 확대되는 높이만큼 간격에서 제외해서
    // 이미지가 무조건 가려지도록 수치 계산했습니다.
    private var imagePadding: CGFloat {
        let originImageWidth: CGFloat = 375
        let originImageHeight: CGFloat = 438
        let screenWidth: CGFloat = UIWindow.current?.screen.bounds.width ?? originImageWidth
        let newImageHeight: CGFloat = originImageHeight * screenWidth / originImageWidth
        let diffHeight = (newImageHeight - originImageHeight) / 2
        return 135 - diffHeight
    }
    
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
                .background(alignment: .bottom) {
                    viewModel.profileType.profileImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.bottom, imagePadding)
                }
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
