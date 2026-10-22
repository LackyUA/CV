//
//  EventEmitter.swift
//  Core
//
//  Created by Andrii Vysotskyi on 08.07.2025.
//

public protocol EventEmitter<Event>: Sendable {

    associatedtype Event: Sendable

    /// A stream of authentication changes.
    var events: AnyAsyncSequence<Event> { get }
}
