//
//  subReservationCardListView.swift
//  HomeFeature
//
//  Created by 박병호 on 6/23/25.
//

import SwiftUI

import HomeDomain
import HGDesignSystem
import NukeUI

struct HomeSubReservationCardListView: View {
    let statusTab: ReservationStatusTab
    let reservations: [ReservationInfo]
    let totalCount: Int
    let mainReservationCount: Int
    let lastItemAction: () -> Void
    
    init(
        statusTab: ReservationStatusTab,
        reservations: [ReservationInfo],
        totalCount: Int,
        mainReservationCount: Int = 0,
        lastItemAction: @escaping () -> Void
    ) {
        self.statusTab = statusTab
        self.reservations = reservations
        self.totalCount = totalCount
        self.mainReservationCount = mainReservationCount
        self.lastItemAction = lastItemAction
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 4) {
                Text(statusTab.listTitle)
                    .setTypo(.subTitle_18_bold)
                    .foregroundStyle(.gray80)
                
                Text("\(totalCount-mainReservationCount)")
                    .setTypo(.subTitle_18_bold)
                    .foregroundStyle(.orange500Main)
            }
            
            LazyVStack(spacing: 12) {
                ForEach(reservations, id: \.reservationId) { info in
                    SubReservationCard(reservationInfo: info)
                        .onAppear {
                            if info.reservationId == reservations.last?.reservationId {
                                lastItemAction()
                            }
                        }
                }
            }
        }
        .fillMaxHeight(.top)
    }
}

struct SubReservationCard: View {
    let reservationInfo: ReservationInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            header
            divider
            content
        }
        .padding(.top, 12)
        .padding([.horizontal, .bottom], 16)
        .background(.gray0White)
        .setRadius(28)
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            OffsetImageStack(
                images: reservationInfo.profileImageTypeList.map { $0.image },
                imageLength: 28,
                spacing: 20,
                maxVisibleCount: 3
            )
            
            Spacer().frame(width: 4)
            
            Text(reservationInfo.participantCount > 1
                 ? "\(reservationInfo.participantCount)명 참여중!" : "혼자 참여중!")
                .setTypo(.body_14_bold)
                .foregroundStyle(.gray80)
            
            Spacer()
            
            HGTagView(
                style: .small,
                title: reservationInfo.categoryType.title,
                textColor: reservationInfo.categoryType.mainColor,
                backgroundColor: reservationInfo.categoryType.lightColor
            )
        }
    }
    
    private var divider: some View {
        Rectangle()
            .foregroundStyle(HGColors.gray15)
            .frame(height: 1)
    }
    
    private var content: some View {
        HStack(spacing: 12) {
            reservationInfo.categoryType.thumbnail
                .frame(width: 64, height: 64)
                .setRadius(16)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(reservationInfo.title)
                    .setTypo(.body_16_bold)
                    .padding(.leading, 4)
                
                HStack(spacing: 6) {
                    HStack(spacing: 2) {
                        HGIcons.calendar.image
                            .resizable()
                            .frame(16)
                            .foregroundStyle(.gray40)
                        
                        Text(reservationInfo.reservationDatetime.formatted(with: .yyyyMMddKorean))
                            .setTypo(.body_14_medium)
                            .foregroundStyle(.gray50)
                    }
                    
                    HStack(spacing: 2) {
                        HGIcons.timer.image
                            .resizable()
                            .frame(16)
                            .foregroundStyle(.gray40)
                        
                        Text(reservationInfo.reservationDatetime.formatted(with: .ahhmm))
                            .setTypo(.body_14_medium)
                            .foregroundStyle(.gray50)
                    }
                }
            }
        }
    }
}

#Preview(traits: .applyFont) {
    HomeSubReservationCardListView(
        statusTab: .scheduled,
        reservations: [
            
        ],
        totalCount: 30,
        mainReservationCount: 2,
        lastItemAction: {
            
        }
    )
}
