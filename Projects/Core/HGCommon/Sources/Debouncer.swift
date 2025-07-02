//
//  Debouncer.swift
//  HGCommon
//
//  Created by Enes on 6/24/25.
//

import Foundation

public actor Debouncer {   
    private var task: Task<Void, Never>?
    public init() { }
    
    public func debounce(
        delay: TimeInterval,
        action: @escaping @Sendable () async -> Void
    ) {
        task?.cancel()
        task = Task {
            try? await Task.sleep(for: .seconds(delay))
            if !Task.isCancelled {
                await action()
            }
        }
    }
}
