//
//  ReservationView.swift
//  Reservation
//
//  Created by 김남수 on 25/06/14.
//

import SwiftUI

import HGCommon
import HGDesignSystem

struct ReservationView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(alignment: .top) {
            background
            
            ScrollView {
                VStack(spacing: 0) {
                    TitleView
                    
                    Spacer().frame(height: 49)
                    
                    timerView
                }
            }
        }
        .environment(\.colorScheme, .dark)
    }
    
    var background: some View {
        HGGradient.blueSub
            .frame(height: 637)
    }
    
    var TitleView: some View {
        VStack(spacing: 0) {
            HGTagView(
                style: .medium,
                title: "액티비티",
                textColor: .gray10,
                backgroundColor: HGColors.opacityWhite30 // TODO white10으로 바꿔야됨
            )
            
            Spacer().frame(height: 20)
            
            Text("펜타포트 예매")
                .setTypo(.display_32_extraBold)
                .foregroundStyle(.gray0White)
            
            HStack(spacing: 2) {
                HGIcons.calendar.image
                    .resizable()
                    .frame(16)
                    .foregroundStyle(.opacityWhite30)
                
                Text(Date().formatted(with: .yyyyMMddKorean))
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.opacityWhite60)
                
                HGIcons.timer.image
                    .resizable()
                    .frame(16)
                    .foregroundStyle(.opacityWhite30)
                
                Text(Date().formatted(with: .ahhmm))
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.opacityWhite60)
            }
            
            Spacer().frame(height: 8)
            
            HStack(spacing: 0) {
                HGImages.fire.image
                    .resizable()
                    .frame(18)
                
                Group {
                    Text("같은 예약에 ")
                    Text("24명").foregroundStyle(.orange700)
                    Text(" 도전중")
                }
                .setTypo(.caption_12_medium)
                .foregroundStyle(.gray90)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.opacityWhite60)
            .clipShape(Capsule())
        }
    }
    
    private var timerView: some View {
        VStack(spacing: 0) {
            Text("D-74")
                .setTypo(.heading_24_bold)
                .foregroundStyle(.gray0White)
            
            Spacer().frame(height: 8)
            
            HStack(spacing: 4) {
                TimerView(
                    time: "10",
                    description: "시간",
                    backgroundColor: HGColors.opacityPurple4.color
                )
                
                Text(":")
                    .setTypo(.display_32_extraBold)
                    .foregroundStyle(.opacityWhite60)
                
                TimerView(
                    time: "42",
                    description: "분",
                    backgroundColor: HGColors.opacityPurple4.color
                )
                
                Text(":")
                    .setTypo(.display_32_extraBold)
                    .foregroundStyle(.opacityWhite60)
                
                TimerView(
                    time: "21",
                    description: "초",
                    backgroundColor: HGColors.opacityPurple4.color
                )
            }
        }
        .environment(\.colorScheme, .light)
    }
}

#Preview {
    ReservationView()
}
