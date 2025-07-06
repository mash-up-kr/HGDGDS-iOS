//
//  Date+Extension.swift
//  HGCommon
//
//  Created by 박병호 on 6/29/25.
//

import Foundation

extension Date {
    /// 오늘 기준으로 D-Day 차이를 정수(Int)로 반환합니다.
    /// 예: 오늘이면 0, 내일이면 1, 어제면 -1
    public func dDayValue(from referenceDate: Date = Date()) -> Int {
        let calendar = Calendar.current
        let startOfTarget = calendar.startOfDay(for: self)
        let startOfToday = calendar.startOfDay(for: referenceDate)
        
        let components = calendar.dateComponents([.day], from: startOfToday, to: startOfTarget)
        return components.day ?? 0
    }
}
