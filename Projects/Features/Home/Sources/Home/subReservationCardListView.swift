//
//  subReservationCardListView.swift
//  HomeFeature
//
//  Created by 박병호 on 6/23/25.
//

import SwiftUI

import HGDesignSystem
import NukeUI

struct subReservationCardListView: View {
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 4) {
                Text(title)
                    .setTypo(.subTitle_18_bold)
                    .foregroundStyle(.gray80)
                
                Text("4")
                    .setTypo(.subTitle_18_bold)
                    .foregroundStyle(.orange500Main)
            }
            
            LazyVStack(spacing: 12) {
                ForEach(0..<14) { _ in
                    subReservationCard(
                        category: .restaurant,
                        mainImageURLString: "https://i.pravatar.cc/150?img=4",
                        title: "매쉬업 야구 직관 모임",
                        date: Date(),
                        userImageURLStrings: [
                            // 임시 URL
                            "https://i.pravatar.cc/150?img=4",
                            "https://i.pravatar.cc/300",
                            "https://i.pravatar.cc/150?img=3",
                        ]
                    )
                }
            }
        }
        .fillMaxHeight(.top)
    }
}

struct subReservationCard: View {
    let category: ReservationCategoryType
    let mainImageURLString: String?
    let title: String
    let date: Date
    let userImageURLStrings: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            hedaer
            divider
            content
        }
        .padding(.top, 12)
        .padding([.horizontal, .bottom], 16)
        .background(.gray0White)
        .setRadius(28)
    }
    
    var hedaer: some View {
        HStack(spacing: 0) {
            OffsetImageStack(
                imageURLStrings: userImageURLStrings,
                imageLength: 28,
                spacing: 20,
                maxVisibleCount: 3
            )
            
            Spacer()
                .frame(width: 4)
            
            Text(userImageURLStrings.count > 1 ? "\(userImageURLStrings.count)명 참여중!" : "혼자 참여중!")
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
    }
    
    var divider: some View {
        Rectangle()
            .foregroundStyle(HGColors.gray15)
            .frame(height: 1)
    }
    
    var content: some View {
        HStack(spacing: 12) {
            LazyImage(url: URL(string: mainImageURLString ?? "")) { state in
                if let image = state.image {
                    image
                        .resizable()
                } else if state.error != nil {
                    HGColors.opacityBlack10.color
                } else {
                    HGColors.opacityBlack10.color
                }
            }
            .frame(width: 64, height: 64)
            .setRadius(16)
            
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
                            .setTypo(.body_14_medium)
                            .foregroundStyle(.gray50)
                    }
                    
                    HStack(spacing: 2) {
                        HGIcons.timer.image
                            .foregroundStyle(.gray40)
                        
                        Text(date.formatted(with: .ahhmm))
                            .setTypo(.body_14_medium)
                            .foregroundStyle(.gray50)
                    }
                }
            }
        }
    }
}

#Preview(traits: .applyFont) {
    subReservationCardListView(title: "예정된 예약")
}
