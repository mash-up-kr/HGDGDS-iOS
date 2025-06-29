//
//  MainReservationCard.swift
//  HomeFeature
//
//  Created by 박병호 on 6/23/25.
//

import SwiftUI

import HomeDomain
import HGCommon
import HGDesignSystem

struct MainReservationCard: View {
    let reservationInfo: ReservationInfo
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            
            Spacer().frame(height: 10)
            
            content
            
            Spacer().frame(height: 16)
            
            HGButton(title: "자세히 보기", isMaxWidth: true) {
                action()
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
                imageURLStrings: reservationInfo.images,
                imageLength: 28,
                spacing: 20,
                maxVisibleCount: 3
            )
            
            Spacer().frame(width: 4)
            
            Text(reservationInfo.participantCount > 1 ? "\(reservationInfo.participantCount)명 참여중!" : "혼자 참여중!")
                .setTypo(.body_14_bold)
                .foregroundStyle(.gray80)
            
            Spacer()
            
            HGTagView(
                style: .medium,
                title: reservationInfo.category.name,
                textColor: reservationInfo.category.mainColor,
                backgroundColor: reservationInfo.category.lightColor
            )
        }
        .padding(.leading, 4)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(reservationInfo.title)
                .setTypo(.title_20_bold)
                .foregroundStyle(.gray95)
                .padding(.bottom, 2)
            
            HStack(spacing: 6) {
                HStack(spacing: 2) {
                    HGIcons.calendar.image
                        .foregroundStyle(.gray40)
                    
                    Text(reservationInfo.reservationDatetime.formatted(with: .yyyyMMddKorean))
                        .setTypo(.body_14_medium)
                        .foregroundStyle(.gray50)
                }
                
                HStack(spacing: 2) {
                    HGIcons.timer.image
                        .foregroundStyle(.gray40)
                    
                    Text(reservationInfo.reservationDatetime.formatted(with: .ahhKorean))
                        .setTypo(.body_14_medium)
                        .foregroundStyle(.gray50)
                }
            }
        }
        .padding(.leading, 4)
    }
}

#Preview(traits: .applyFont) {
    MainReservationCard(reservationInfo:
            .init(
                reservationId: 0,
                title: "남수와 함께하는 클라이밍",
                category: .activity,
                reservationDatetime: Date(),
                participantCount: 4,
                maxParticipants: 6,
                hostId: 11,
                hostNickname: "남수",
                images: [
                    "https://i.pravatar.cc/150?img=4",
                    "https://i.pravatar.cc/300",
                    "https://i.pravatar.cc/150?img=3",
                ],
                userStatus: "가자",
                isHost: true
            ), action: {
                
            }
    )
}
