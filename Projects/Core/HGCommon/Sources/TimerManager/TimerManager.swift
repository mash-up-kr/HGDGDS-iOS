//
//  TimerManager.swift
//  HGCommon
//
//  Created by Enes on 6/17/25.
//

import Foundation

public final class TimerManager {
    private var backgroundTimer: (any DispatchSourceTimer)?
    public var isRunning: Bool { backgroundTimer != nil }
    private var onEvent: (() -> Void)?
    
    public init() { }
    
    deinit {
        stop()
        onEvent = nil
    }
    
    /// - Note: background thread사용으로 주의가 필요합니다
    public func setEvent(_ onEvent: @escaping () -> Void) {
        self.onEvent = onEvent
    }
    
    public func start(interval: Int) {
        guard backgroundTimer == nil else { return }
        let backgroundTimer = DispatchSource.makeTimerSource(queue: .global(qos: .background))
        backgroundTimer.schedule(deadline: .now(), repeating: .seconds(interval))
        backgroundTimer.setEventHandler { [weak self] in
            self?.onEvent?()
        }
        backgroundTimer.activate()
        self.backgroundTimer = backgroundTimer
    }
    
    public func stop() {
        backgroundTimer?.cancel()
        backgroundTimer = nil
    }
}
