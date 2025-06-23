//
//  SubReservationCardList.swift
//  HomeFeature
//
//  Created by 박병호 on 6/23/25.
//

import SwiftUI

import HGDesignSystem

struct subReservationCardList: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 4) {
                Text("예정된 예약")
                    .setTypo(.subTitle_18_bold)
                    .foregroundStyle(.gray80)
                
                Text("4")
                    .setTypo(.subTitle_18_bold)
                    .foregroundStyle(.orange500Main)
            }
            
            VStack(spacing: 12) {
                ForEach(0..<4) { _ in
                    subReservationCard(
                        category: .restaurant,
                        title: "매쉬업 야구 직관 모임",
                        date: Date(),
                        images: []
                    )
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

struct subReservationCard: View {
    let category: ReservationCategoryType
    let title: String
    let date: Date
    let images: [Image]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                Image(.imageTemp)
                    .setRadius(30)
                
                Spacer()
                    .frame(width: 4)
                
                Text("\(images.count)명 참여중!")
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.gray80)
                
                Spacer()
                
                HGTagView(
                    style: .small,
                    title: category.name,
                    textColor: category.mainColor,
                    backgroundColor: category.lightColor
                )
            }
            
            Rectangle()
                .foregroundStyle(HGColors.gray15)
                .frame(height: 1)
            
            HStack(spacing: 12) {
                Rectangle()
                    .foregroundStyle(.gray30)
                    .setRadius(16)
                    .frame(width: 64, height: 64)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .setTypo(.title_20_bold)
                        .padding(.leading, 4)
                    
                    Spacer()
                        .frame(height: 2)
                    
                    HStack(spacing: 6) {
                        HStack(spacing: 2) {
                            HGIcons.calendar.image
                                .foregroundStyle(.gray40)
                            
                            Text(date.formatted(with: .yyyyMMddKorean))
                                .setTypo(.body_14_bold)
                                .foregroundStyle(.gray50)
                        }
                        
                        HStack(spacing: 2) {
                            HGIcons.timer.image
                                .foregroundStyle(.gray40)
                            
                            Text(date.formatted(with: .ahhmm))
                                .setTypo(.body_14_bold)
                                .foregroundStyle(.gray50)
                        }
                    }
                }
            }
        }
        .padding(.top, 12)
        .padding([.horizontal, .bottom], 16)
        .background(.gray0White)
        .setRadius(28)
    }
}

#Preview(traits: .applyFont) {
    subReservationCardList()
}
