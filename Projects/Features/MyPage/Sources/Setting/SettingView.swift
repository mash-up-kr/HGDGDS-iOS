//
//  SettingView.swift
//  MyPageFeature
//
//  Created by Enes on 6/22/25.
//

import SwiftUI
import HGDesignSystem

struct SettingView: View {
    @State private var viewModel: SettingViewModel = .init()
    
    var body: some View {
        VStack(spacing: 24) {
            profileView
            HGDividerView()
            alarmSettingView
            HGDividerView()
            customerSupportView
        }
        .padding(.horizontal, 16)
        .padding(.top, 26)
        .applyNavigationBar(title: "설정")
        .onAppear { viewModel.reduce(.setup) }
    }
    
    private var profileView: some View {
        HStack {
            Text("날아라 병아리")
                .setTypo(.title_20_bold)
                .foregroundStyle(.gray100Black)
            Spacer()
            HGButton(title: "프로필 편집", size: .xSmall, variant: .subtle, isMaxWidth: false) {
                print("프로필 편집")
            }
        }
    }
    
    private var alarmSettingView: some View {
        VStack(alignment: .leading, spacing: 24) {
            sectionTitleView("알림 설정")
            alarmControlView(title: "예약 전 진동 알림", isOn: $viewModel.state.isOnReservationAlarm)
            alarmControlView(title: "콕 찌르기 알림", isOn: $viewModel.state.isOnKokAlarm)
        }
    }
    
    private func alarmControlView(title: String, isOn: Binding<Bool>) -> some View {
        HStack {
            Text(title)
                .setTypo(.body_16_medium)
                .foregroundStyle(.gray95)
            Toggle("", isOn: isOn)
                .tint(HGColors.orange500Main.color)
        }
    }
    
    private var customerSupportView: some View {
        VStack(alignment: .leading, spacing: 24) {
            sectionTitleView("고객 지원")
            HStack {
                Text("버전 정보")
                    .setTypo(.body_16_medium)
                    .foregroundStyle(.gray95)
                Spacer()
                Text(viewModel.versionString)
                    .setTypo(.body_16_medium)
                    .foregroundStyle(.gray50)
            }
        }
    }
    
    private func sectionTitleView(_ title: String) -> some View {
        Text(title)
            .setTypo(.caption_12_medium)
            .foregroundStyle(.gray50)
    }
}

#Preview(traits: .applyFont) {
    SettingView()
}
