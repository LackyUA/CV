//
//  AnyEquatable.swift
//  Core
//
//  Created by Andrii Vysotskyi on 05.12.2025.
//

public struct AnyEquatable: Equatable {

    /// Creates a type-erased equatable value that wraps the given instance.
    public init<E>(_ base: E) where E: Equatable {
        self.base = base
        self.equals = { $0 as? E == base }
    }

    /// The value wrapped by this instance.
    ///
    /// The `base` property can be cast back to its original type using one of
    /// the type casting operators (`as?`, `as!`, or `as`).
    public var base: Any

    // MARK: - Equatable

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.equals(rhs.base)
    }

    // MARK: - Private Properties

    private let equals: (Any) -> Bool
}
