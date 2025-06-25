//
//  MainReservationCard.swift
//  HomeFeature
//
//  Created by 박병호 on 6/23/25.
//

import SwiftUI

import HGDesignSystem
import HGCommon

struct MainReservationCard: View {
    let category: ReservationCategoryType
    let title: String
    let date: Date
    let userImageURLStrings: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            
            Spacer()
                .frame(height: 10)
            
            content
            
            Spacer()
                .frame(height: 16)
            
            HGButton(title: "자세히 보기", isMaxWidth: true) {
                
            }
        }
        .padding(12)
        .background(.gray0White)
        .setRadius(30)
        .strokeBorder(HGColors.gray10.color, radius: 30, linewidth: 1)
        .cardViewShadow()
    }
    
    var header: some View {
        HStack(spacing: 0) {
            OffsetImageStack(
                imageURLStrings: userImageURLStrings,
                imageLength: 28,
                spacing: 20,
                maxVisibleCount: 3
            )
            
            Spacer()
                .frame(width: 4)
            
            Text("7명 참여중!")
                .setTypo(.body_14_bold)
                .foregroundStyle(.gray80)
            
            Spacer()
            
            HGTagView(
                style: .medium,
                title: category.name,
                textColor: category.mainColor,
                backgroundColor: category.lightColor
            )
        }
        .padding(.leading, 4)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("매쉬업 야구 직관 모임")
                .setTypo(.title_20_bold)
                .foregroundStyle(.gray95)
                .padding(.bottom, 2)
            
            HStack(spacing: 6) {
                HStack(spacing: 2) {
                    HGIcons.calendar.image
                        .foregroundStyle(.gray40)
                    
                    Text(date.formatted(with: .yyyyMMddKorean))
                        .setTypo(.body_14_medium)
                        .foregroundStyle(.gray50)
                }
                
                HStack(spacing: 2) {
                    HGIcons.timer.image
                        .foregroundStyle(.gray40)
                    
                    Text(date.formatted(with: .ahhKorean))
                        .setTypo(.body_14_medium)
                        .foregroundStyle(.gray50)
                }
            }
        }
        .padding(.leading, 4)
    }
}

#Preview(traits: .applyFont) {
    MainReservationCard(
        category: .restaurant,
        title: "매쉬업 야구 직관 모임",
        date: Date(),
        userImageURLStrings: []
    )
}
