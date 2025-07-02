//
//  ReservationResultDetailView.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 7/1/25.
//

import SwiftUI
import HGDesignSystem
import NukeUI

struct ReservationResultDetailView: View {
    var body: some View {
        
        VStack(spacing: 0) {
            HGColors.gray10.color.frame(height: 1)
            profileHeaderView
            
            ScrollView {
                VStack(spacing: 12) {
                    reservationSuccessDateSectionView
                    sharedPhotoSectionView
                    descriptionSectionView
                }
                .padding(.horizontal, 16)
            }
            .background(.gray10)
            .contentMargins(.top, 20)
        }
        .applyNavigationBar(title: "예약 결과 상세")
    }
    
    private var profileHeaderView: some View {
        HStack(spacing: 15) {
            Color.red
                .frame(62)
                .setRadius(24)
            VStack(alignment: .leading, spacing: 4) {
                Text("매쉬업 야구장 직관 모임")
                    .setTypo(.caption_12_bold)
                    .foregroundStyle(.orange500Main)
                Text("김프디(나)")
                    .setTypo(.subTitle_18_bold)
                    .foregroundStyle(.gray95)
            }
        }
        .fillMaxWidth()
        .padding(.horizontal, 16)
        .frame(height: 102)
    }
    
    private var reservationSuccessDateSectionView: some View {
        makeSectionContainerView(title: "예약 성공 일자") {
            HStack(spacing: 16) {
                HStack(spacing: 2) {
                    HGIcons.calendar.image
                        .resizable()
                        .frame(20)
                        .foregroundStyle(.gray50)
                    Text("0000년 00월 00일")
                        .setTypo(.body_16_medium)
                        .foregroundStyle(.gray95)
                }
                HStack(spacing: 2) {
                    HGIcons.timer.image
                        .resizable()
                        .frame(20)
                        .foregroundStyle(.gray50)
                    Text("오후 0시")
                        .setTypo(.body_16_medium)
                        .foregroundStyle(.gray95)
                }
            }
        }
    }
    
    @ViewBuilder
    private var sharedPhotoSectionView: some View {
        let urls: [URL] = [
            URL(string: "https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_8_854x480.png")!,
            URL(string: "https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_8_854x480.png")!,
            URL(string: "https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_8_854x480.png")!
        ]
        makeSectionContainerView(title: "사진") {
            if urls.isEmpty {
                makeEmptyView(title: "공유된 사진이 없어요")
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 9) {
                        ForEach(urls.indices, id: \.self) { index in
                            LazyImage(url: urls[index]) { state in
                                if let image = state.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(106)
                                } else {
                                    HGColors.gray10.color
                                }
                            }
                            .strokeBorder(HGColors.opacityBlack10.color, radius: 15, linewidth: 0.75)
                        }
                    }
                }
                .scrollIndicators(.never)
            }
        }
    }
    
    @ViewBuilder
    private var descriptionSectionView: some View {
        let descriptionString: String = ""
        makeSectionContainerView(title: "설명") {
            if descriptionString.isEmpty {
                makeEmptyView(title: "공유된 설명이 없어요")
            } else {
                Text("설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명")
                    .setTypo(.body_16_medium)
                    .foregroundStyle(.gray95)
            }
        }
    }
    
    private func makeSectionContainerView(
        title: String,
        @ViewBuilder childView: () -> some View
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .setTypo(.subTitle_18_bold)
                .foregroundStyle(.gray95)
            childView()
        }
        .fillMaxWidth()
        .padding([.horizontal, .top], 16)
        .padding(.bottom, 22)
        .background(.gray0White)
        .setRadius(28)
    }
    
    private func makeEmptyView(title: String) -> some View {
        VStack(spacing: 16) {
            Color.red.frame(120)
            Text(title)
                .setTypo(.body_16_bold)
                .foregroundStyle(.gray30)
        }
        .fillMaxWidth(.center)
    }
}

#Preview(traits: .applyFont) {
    ReservationResultDetailView()
}
