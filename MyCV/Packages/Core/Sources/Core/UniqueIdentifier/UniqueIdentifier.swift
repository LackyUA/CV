//
//  UniqueIdentifier.swift
//  Core
//
//  Created by Andrii Vysotskyi on 19.06.2026.
//

/// A type-safe identifier for a given `Value`, backed by a raw value.
public struct UniqueIdentifier<Value, RawValue: Hashable>: RawRepresentable, Hashable {

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }

    public let rawValue: RawValue
}

extension UniqueIdentifier: CustomStringConvertible where RawValue: CustomStringConvertible {

    public var description: String {
        rawValue.description
    }
}

extension UniqueIdentifier: CustomDebugStringConvertible where RawValue: CustomDebugStringConvertible {

    public var debugDescription: String {
        rawValue.debugDescription
    }
}

extension UniqueIdentifier: Sendable where RawValue: Sendable { }
