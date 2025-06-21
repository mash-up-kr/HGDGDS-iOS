//
//  SuccessRateView.swift
//  MyPageFeature
//
//  Created by Enes on 6/21/25.
//

import SwiftUI
import HGDesignSystem

struct SuccessRateView: View {
    let allCount: Int
    let successCount: Int
    let tintColor: HGColors
    let sliderGradient: LinearGradient
    let backgroundColor: HGColors
    
    var successRate: Double { Double(successCount) / Double(allCount) }
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 4) {
                HStack {
                    HGTagView(
                        style: .medium,
                        title: "나의 예약 성공률",
                        textColor: tintColor,
                        backgroundColor: backgroundColor
                    )
                }
                Text("\(Int(successRate * 100))%")
                    .setTypo(.display_40_extraBold)
                sliderView
            }
            HStack {
                Spacer()
                reservationDescriptionView(title: "전체예약", num: allCount)
                Spacer()
                divider
                Spacer()
                reservationDescriptionView(title: "전체예약", num: successCount)
                Spacer()
            }
            .frame(height: 88)
            .background(.gray10)
            .setRadius(20)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(HGColors.gray0White.color)
        .setRadius(20)
    }
    
    private func reservationDescriptionView(title: String, num: Int) -> some View {
        VStack(spacing:1) {
            Text(title)
                .setTypo(.body_14_medium)
                .foregroundStyle(.gray60)
            Text("\(num)개")
                .setTypo(.title_20_bold)
                .foregroundStyle(.gray95)
        }
    }
    
    private var divider: some View {
        HGColors.gray20.color
            .frame(width: 2, height: 43)
    }
    
    private var sliderView: some View {
        VStack(spacing: 6) {
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    HGColors.gray20.color
                    sliderGradient
                        .frame(width: proxy.size.width * successRate)
                }
                .clipShape(Capsule())
                .overlay(alignment: .leading) {
                    sliderThumbView
                        .position(x: proxy.size.width * successRate, y: proxy.size.height/2)
                }
            }
            .frame(height: 10)
            HStack {
                Text("0%")
                Spacer()
                Text("100%")
            }
            .setTypo(.caption_12_medium)
            .foregroundStyle(.gray40)
        }
    }
    
    private var sliderThumbView: some View {
        ZStack {
            Circle()
                .foregroundStyle(.gray0White)
                .frame(20)
            Circle()
                .foregroundStyle(tintColor)
                .frame(12)
        }
        .shadow(radius: 12)
    }
}

#Preview(traits: .applyFont) {
    SuccessRateView(
        allCount: 3,
        successCount: 2,
        tintColor: .purpleMain,
        sliderGradient: HGGradient.purpleMainWidth,
        backgroundColor: .purpleLight
    )
}
