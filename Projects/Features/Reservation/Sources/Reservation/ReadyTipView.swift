//
//  ReadyTipView.swift
//  ReservationFeature
//
//  Created by 박병호 on 7/6/25.
//

import SwiftUI

import HGDesignSystem

struct ReadyTipView: View {
    var body: some View {
        VStack(spacing: 40) {
            ReservationReadyPromptView
            
            tipView
        }
        .padding(.top, 17)
        .fillMaxSize(.top)
        .background(.gray10)
        .applyNavigationBar(title: "")
    }
    
    var ReservationReadyPromptView: some View {
        VStack(spacing: 34) {
            Text("예약 1시간 전 친구들에게\n준비 상태를 알려주세요!")
                .setTypo(.heading_24_bold)
                .foregroundStyle(.gray95)
                .multilineTextAlignment(.center)
            
            HGImages.readyBell.image
                .resizable()
                .frame(102)
        }
    }
    
    var tipView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("예약 1시간 전")
                Text(" 준비중 버튼 ")
                    .foregroundStyle(.orange500Main)
                Text("활성화")
            }
            .setTypo(.subTitle_18_bold)
            .foregroundStyle(.gray95)
            
            Spacer().frame(height: 8)
            
            Text("준비중 버튼을 누르면\n친구들에게 상태를 알려줄 수 있어요")
                .setTypo(.body_14_bold)
                .foregroundStyle(.gray60)
                .multilineTextAlignment(.center)
            
            Spacer().frame(height: 23)
            
            HGImages.readyTip.image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 311, maxHeight: 257)
        }
        .padding(.top, 25)
        .padding(.bottom, 20)
        .padding(.horizontal, 16)
        .background(.gray0White)
        .setRadius(30)
    }
}

#Preview(traits: .applyFont) {
    ReadyTipView()
}
