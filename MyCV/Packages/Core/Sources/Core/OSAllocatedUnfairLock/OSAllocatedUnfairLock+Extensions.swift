//
//  OSAllocatedUnfairLock+Extensions.swift
//  Core
//
//  Created by Andrii Vysotskyi on 23.06.2025.
//

import os

extension OSAllocatedUnfairLock where State: Sendable {

    /// Returns the current value of the locked state.
    public var wrappedValue: State {
        withLock { $0 }
    }
}
