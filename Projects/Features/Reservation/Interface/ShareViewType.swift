//
//  ShareViewType.swift
//  ReservationFeature
//
//  Created by iOS신상우 on 7/6/25.
//

import Foundation

public enum ShareViewType: String, CaseIterable {
    case receiver
    case sender
    
    public var title: String {
        switch self {
        case .receiver: "함께 예약을 시작해볼까요?"
        case .sender: "예약 일정이 생성되었어요!"
        }
    }
}
