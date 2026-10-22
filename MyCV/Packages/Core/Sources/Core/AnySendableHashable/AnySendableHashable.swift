//
//  AnySendableHashable.swift
//  Core
//
//  Created by Andrii Vysotskyi on 23.09.2025.
//

/// A Sendable version of the standard library’s AnyHashable type.
public struct AnySendableHashable: Hashable, @unchecked Sendable {

    public init(_ base: any Hashable & Sendable) {
        self._base = .init(base)
    }

    /// The value wrapped by this instance.
    public var base: Any {
        _base
    }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        _base.hash(into: &hasher)
    }

    public static func == (lhs: AnySendableHashable, rhs: AnySendableHashable) -> Bool {
        lhs._base == rhs._base
    }

    // MARK: - Private Properties

    private let _base: AnyHashable
}
