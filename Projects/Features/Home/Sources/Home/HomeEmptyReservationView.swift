//
//  HomeEmptyReservationView.swift
//  HomeFeature
//
//  Created by 박병호 on 6/28/25.
//

import SwiftUI

import HGDesignSystem

struct HomeEmptyReservationView: View {
    var body: some View {
        NoReservationCard()
            .padding([.top, .bottom], 40)
            .fillMaxHeight(.top)
    }
}

private struct NoReservationCard: View {
    var body: some View {
        VStack(spacing: 0) {
            HGImages.noScheduledReservation.image
                .resizable()
                .frame(250)
            
            Spacer().frame(height: 36)
            
            VStack(spacing: 4) {
                Text("아직은 예약이 없어요!")
                    .setTypo(.heading_24_bold)
                    .foregroundStyle(.gray95)
                
                Text("지금 버튼을 눌러\n콕콕과 함께 예약을 시작해 보세요")
                    .setTypo(.body_16_medium)
                    .foregroundStyle(.gray50)
                    .multilineTextAlignment(.center)
            }
            
            Spacer().frame(height: 24)
            
            HGButton(title: "예약 생성하기") {
               
            }
        }
        .padding([.top, .horizontal], 36)
        .padding(.bottom, 48)
        .background(.gray0White)
        .setRadius(40)
        .cardViewShadow()
    }
}

#Preview {
    HomeEmptyReservationView()
}
