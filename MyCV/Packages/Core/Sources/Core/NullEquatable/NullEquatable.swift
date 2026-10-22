//
//  NullEquatable.swift
//  Core
//
//  Created by Andrii Vysotskyi on 08.12.2025.
//

/// A property wrapper that enables all wrapped values to be considered equal,
/// regardless of their actual value.
///
/// When applied, any two instances of `NullEquatable` are always considered
/// equal (`==` returns `true`), even if their underlying values differ.
/// This can be useful in scenarios where value comparisons should be ignored,
/// such as for types that must conform to `Equatable` but where equality
/// semantics are not important for the wrapped value.
@propertyWrapper
public struct NullEquatable<T>: Equatable {

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }

    public var wrappedValue: T

    // MARK: - Equatable

    public static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}

extension NullEquatable: Sendable where T: Sendable { }
