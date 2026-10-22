//
//  NSItemProvider+Concurrency.swift
//  Core
//
//  Created by Andrii Vysotskyi on 03.07.2026.
//

import Foundation
import UniformTypeIdentifiers

extension NSItemProvider {

    /// Asynchronously loads an object of a specified class to an item provider, returning a progress object.
    public func loadObject<T: NSItemProviderReading & SendableMetatype>(of type: T.Type) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            loadObject(ofClass: type) { object, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let object = object as? T {
                    nonisolated(unsafe) let object = object
                    continuation.resume(returning: object)
                } else {
                    preconditionFailure("NSItemProvider violated its completion handler contract.")
                }
            }
        }
    }

    /// Executes `body` with a temporary file provided by the item provider.
    ///
    /// If the file needs to outlive this method, copy it to a persistent
    /// location inside `body`.
    public func withFileRepresentation<T>(
        for type: UTType, openInPlace: Bool = false, _ body: @escaping @Sendable (URL) async throws -> T
    ) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            _ = loadFileRepresentation(for: type, openInPlace: openInPlace) { url, _, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let url {
                    let semaphore = DispatchSemaphore(value: 0)
                    Task {
                        do {
                            let value = try await body(url)
                            continuation.resume(returning: value)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                        semaphore.signal()
                    }
                    semaphore.wait()
                } else {
                    preconditionFailure("NSItemProvider violated its completion handler contract.")
                }
            }
        }
    }
}
