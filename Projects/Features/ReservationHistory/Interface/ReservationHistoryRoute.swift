//
//  ReservationHistoryRoute.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 7/11/25.
//

import Foundation

public enum ReservationHistoryRoute: Hashable {
    /// 예약결과 입력화면
    case resultInput(reservationID: Int)
    /// 예약결과 공유화면
    case resultShare(reservationID: Int, categoryRawValue: String)
    /// 예약결과 멤버별 상세화면
    case resultDetail(ResultDetailRouteModel)
}
