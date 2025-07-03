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
    @State private var viewModel: MyPageViewModel = .init()
    
    var body: some View {
        ZStack {
            HGGradient.purpleMain
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer().frame(height: 58)
                nicknameView
                Spacer()
                SuccessRateView(
                    allCount: 3,
                    successCount: 2,
                    tintColor: .purpleMain,
                    sliderGradient: HGGradient.purpleMainWidth,
                    backgroundColor: .purpleLight
                )
                .padding(.horizontal, 16)
            }
            .applyTabbarHeight(padding: 38)
            .fillMaxSize(.top)
            .overlay(alignment: .topTrailing) { settingButton }
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
        Text("날아라병아리")
            .setTypo(.title_20_bold)
            .foregroundStyle(.gray0White)
            .frame(height: 53)
            .padding(.horizontal, 32)
            .background(.white.opacity(0.1))
            .background(.ultraThinMaterial)
            .strokeBorder(.red, radius: 27, linewidth: 2)
        // TODO: stroke는 디자인컴포넌트 수정이후에 적용할 예정입니다
    }
}


#Preview(traits: .applyFont) {
    MyPageView()
}
