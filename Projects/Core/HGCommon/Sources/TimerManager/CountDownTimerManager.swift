//
//  CountDownTimerManager.swift
//  HGCommon
//
//  Created by Enes on 6/18/25.
//

import Foundation

@Observable
public final class CountDownTimerManager {
    private let timer: TimerManager = TimerManager()
    /// 2025-07-11T19:00:00+09:00
    private var endDate: Date?
    private var remainTime: TimeInterval { ceil(endDate?.timeIntervalSinceNow ?? 0) }
    
    public private(set) var hours: String = "00"
    public private(set) var minutes: String = "00"
    public private(set) var seconds: String = "00"
    public var fullTimeString: String { "\(hours) : \(minutes) : \(seconds)" }
    
    public init() {
        bind()
    }
    
    private func bind() {
        timer.setEvent { [weak self] in
            guard let self else { return }
            if remainTime < 1 {
                self.stop()
            }
            updateRemainDate()
        }
    }
    
    public func setupTime(endDate: Date) {
        self.endDate = endDate
        updateRemainDate()
    }
    
    public func start() {
        timer.start(interval: 1)
    }
    
    private func stop() {
        timer.stop()
    }
    
    public func updateRemainDate() {
        let remainTime = remainTime
        DispatchQueue.main.async { [weak self] in
            self?.hours = String(format: "%02d", Int(remainTime) / 3600)
            self?.minutes = String(format: "%02d", Int(remainTime) % 3600 / 60)
            self?.seconds = String(format: "%02d", Int(remainTime) % 60)
        }
    }
}
