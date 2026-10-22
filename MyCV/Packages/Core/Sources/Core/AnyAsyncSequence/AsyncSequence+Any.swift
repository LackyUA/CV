//
//  AsyncSequence+Any.swift
//  Core
//
//  Created by Andrii Vysotskyi on 19.06.2025.
//

extension AsyncSequence where Self: Sendable, Self.AsyncIterator: SendableMetatype {

    /// Create a type erased version of this sequence
    public func eraseToAnyAsyncSequence() -> AnyAsyncSequence<Element> {
        AnyAsyncSequence(wrapping: self)
    }
}
