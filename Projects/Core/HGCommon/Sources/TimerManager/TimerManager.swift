//
//  TimerManager.swift
//  HGCommon
//
//  Created by Enes on 6/17/25.
//

import Foundation

public final class TimerManager {
    private var timer: Timer?
    public var isRunning: Bool { timer != nil }
    private var onEvent: (() -> Void)?
    
    public init() { }
    
    deinit {
        stop()
        onEvent = nil
    }
    
    public func setEvent(_ onEvent: @escaping () -> Void) {
        self.onEvent = onEvent
    }
    
    /// - Note: background thread사용으로 주의가 필요합니다
    public func start(interval: TimeInterval) {
        guard timer == nil else { return }
        
        DispatchQueue.global().async { [weak self] in
            let timer = Timer.scheduledTimer(
                withTimeInterval: interval,
                repeats: true
            ) { [weak self] _ in
                print("클로저",Thread.isMainThread)
                self?.onEvent?()
            }
            self?.timer = timer
            let runLoop = RunLoop.current
            runLoop.add(timer, forMode: .common)
            runLoop.run()
        }
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
}
