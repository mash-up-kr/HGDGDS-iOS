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
    private let queue: DispatchQueue = DispatchQueue(label: "TimerQueue")
    
    public init() { }
    
    deinit {
        stop()
        onEvent = nil
    }
    
    public func setEvent(_ onEvent: @escaping () -> Void) {
        self.onEvent = onEvent
    }
    
    public func start(interval: TimeInterval) {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(
            withTimeInterval: interval,
            repeats: true
        ) {  [weak self] _ in
            self?.queue.async {
                self?.onEvent?()
            }
        }
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
}
