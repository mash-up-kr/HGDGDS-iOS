//
//  CompletedReservationVIew.swift
//  HomeFeature
//
//  Created by 박병호 on 6/25/25.
//

import SwiftUI

struct NoCompletedReservationVIew: View {
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            Image(.noCompleteReservation)
                .resizable()
                .frame(160)
            
            Text("완료된 예약이 없어요")
                .setTypo(.title_20_bold)
                .foregroundStyle(.gray30)
            
            Spacer()
            Spacer()
        }
        .fillMaxHeight(.center)
    }
}

#Preview {
    NoCompletedReservationVIew()
}
