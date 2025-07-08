//
//  Date+Extension.swift
//  HGCommon
//
//  Created by 박병호 on 6/29/25.
//

import Foundation

public extension Date {
    /// 오늘 기준으로 D-Day 차이를 정수(Int)로 반환합니다.
    /// 예: 오늘이면 0, 내일이면 1, 어제면 -1
    func dDayValue(from referenceDate: Date = Date()) -> Int {
        let calendar = Calendar.current
        let startOfTarget = calendar.startOfDay(for: self)
        let startOfToday = calendar.startOfDay(for: referenceDate)
        
        let components = calendar.dateComponents([.day], from: startOfToday, to: startOfTarget)
        return components.day ?? 0
    }
    
    /// 기존Date에 hms를 합성해서 ymdhms가 필요한 경우 사용합니다
    func combineWith(time: Date) -> Date {
        let calendar = Calendar.current
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
        
        return calendar.date(
            bySettingHour: timeComponents.hour ?? 0,
            minute: timeComponents.minute ?? 0,
            second: timeComponents.second ?? 0,
            of: self
        ) ?? self
    }
}
