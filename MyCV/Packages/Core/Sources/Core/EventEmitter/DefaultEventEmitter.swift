//
//  DefaultEventEmitter.swift
//  Core
//
//  Created by Andrii Vysotskyi on 08.07.2025.
//

import Foundation
@preconcurrency import os

public final class DefaultEventEmitter<Event: Sendable>: EventEmitter {

    public init() {
        continuations = .init(initialState: [:])
    }

    // MARK: - EventEmitter

    public var events: AnyAsyncSequence<Event> {
        let stream = AsyncStream(Event.self) { continuation in
            let id = UUID()
            continuations.withLock { continuations in
                continuations[id] = continuation
            }
            continuation.onTermination = { [weak self] _ in
                self?.removeContinuation(id: id)
            }
        }
        return stream.eraseToAnyAsyncSequence()
    }

    public func emit(event: Event) {
        continuations.wrappedValue.values.forEach { $0.yield(event) }
    }

    // MARK: - Private Properties

    private let continuations: OSAllocatedUnfairLock<[UUID: AsyncStream<Event>.Continuation]>

    // MARK: - Private Methods

    private func removeContinuation(id: UUID) {
        continuations.withLock { $0[id] = nil }
    }
}
