//
//  AnyAsyncSequence.swift
//  Core
//
//  Created by Andrii Vysotskyi on 19.06.2025.
//

import Foundation

public struct AnyAsyncSequence<Element>: AsyncSequence, Sendable {

    public init<S: AsyncSequence & Sendable>(
        wrapping sequence: S
    ) where S.Element == Element, S.AsyncIterator: SendableMetatype {
        self._makeAsyncIterator = {
            AsyncIterator(wrapping: sequence.makeAsyncIterator())
        }
    }

    public func makeAsyncIterator() -> AsyncIterator {
        self._makeAsyncIterator()
    }

    public struct AsyncIterator: AsyncIteratorProtocol, SendableMetatype {

        public init<I: AsyncIteratorProtocol>(wrapping iterator: I) where I.Element == Element {
            self.iterator = iterator
        }

        public mutating func next() async -> Element? {
            try? await self.iterator.next() as? Element
        }

        // MARK: - Private Properties

        private var iterator: any AsyncIteratorProtocol
    }

    // MARK: - Private Properties

    private let _makeAsyncIterator: @Sendable () -> AsyncIterator
}
