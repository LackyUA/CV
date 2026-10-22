//
//  Task+Immediate.swift
//  Core
//
//  Created by Andrii Vysotskyi on 13.11.2025.
//

import Foundation

// swiftlint:disable line_length

extension Task where Failure == any Error {

    /// Creates and returns a new `Task` that executes the provided operation immediately if possible,
    /// using the `immediate` initializer on supported platforms, or falling back to the standard initializer otherwise.
    @discardableResult
    public static func immediateIfPossible(
        priority: TaskPriority? = nil,
        @_implicitSelfCapture @_inheritActorContext(always) operation: sending @isolated(any) @escaping () async throws -> Success
    ) -> Task<Success, Failure> {
        if #available(iOS 26, *) {
            Task.immediate(priority: priority, operation: operation)
        } else if Thread.isMainThread {
            MainActor.assumeIsolated {
                Task.startOnMainActor(priority: priority) {
                    try await operation()
                }
            }
        } else {
            Task(priority: priority, operation: operation)
        }
    }

    @_silgen_name("$sScTss5Error_pRs_rlE16startOnMainActor8priority_ScTyxsAA_pGScPSg_xyYaYbKScMYccntFZ")
    @MainActor
    @discardableResult
    private static func startOnMainActor(
        priority: TaskPriority?,
        @_inheritActorContext @_implicitSelfCapture _ work: __owned @Sendable @escaping @MainActor () async throws -> Success
    ) -> Task<Success, Error>
}

extension Task where Failure == Never {

    /// Creates and returns a new `Task` that executes the provided operation immediately if possible,
    /// using the `immediate` initializer on supported platforms, or falling back to the standard initializer otherwise.
    @discardableResult
    public static func immediateIfPossible(
        priority: TaskPriority? = nil,
        @_implicitSelfCapture @_inheritActorContext(always) operation: sending @isolated(any) @escaping () async -> Success
    ) -> Task<Success, Never> {
        if #available(iOS 26, *) {
            Task.immediate(priority: priority, operation: operation)
        } else if Thread.isMainThread {
            MainActor.assumeIsolated {
                Task.startOnMainActor(priority: priority) {
                    await operation()
                }
            }
        } else {
            Task(priority: priority, operation: operation)
        }
    }

    @_silgen_name("$sScTss5NeverORs_rlE16startOnMainActor8priority_ScTyxABGScPSg_xyYaYbScMYccntFZ")
    @MainActor
    @discardableResult
    private static func startOnMainActor(
        priority: TaskPriority? = nil,
        @_inheritActorContext @_implicitSelfCapture _ work: __owned @Sendable @escaping @MainActor () async throws -> Success
    ) -> Task<Success, Never>
}

// https://github.com/apple/swift/blob/98e65d015979c7b5a58a6ecf2d8598a6f7c85794/stdlib/public/Concurrency/Task.swift#L250-L294

// swiftlint:enable line_length
