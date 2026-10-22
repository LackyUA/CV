//
//  Cache.swift
//  Services
//
//  Created by Andrii Vysotskyi on 30.06.2025.
//

import Foundation

public final class Cache<Key: Hashable, Value> {

    public init() {
        storage = .init()
    }

    // MARK: -

    public func insert(_ value: Value, forKey key: Key, cost: Int) {
        storage.setObject(ValueWrapper(value), forKey: KeyWrapper(key), cost: cost)
    }

    public func value(forKey key: Key) -> Value? {
        storage.object(forKey: KeyWrapper(key))?.wrappedValue
    }

    public func removeValue(forKey key: Key) {
        storage.removeObject(forKey: KeyWrapper(key))
    }

    public var totalCostLimit: Int {
        get { storage.totalCostLimit }
        set { storage.totalCostLimit = newValue }
    }

    // MARK: - Private Properties

    private let storage: NSCache<KeyWrapper<Key>, ValueWrapper<Value>>
}

extension Cache: @unchecked Sendable where Key: Sendable, Value: Sendable { }

// MARK: - Key

private final class KeyWrapper<T: Hashable>: NSObject {

    init(_ wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }

    let wrappedValue: T

    // MARK: - NSObject

    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? KeyWrapper<T> else {
            return false
        }
        return wrappedValue == other.wrappedValue
    }

    override var hash: Int {
        var hasher = Hasher()
        wrappedValue.hash(into: &hasher)
        return hasher.finalize()
    }
}

extension KeyWrapper: Sendable where T: Sendable { }

// MARK: - Value

private final class ValueWrapper<T> {

    init(_ wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }

    let wrappedValue: T
}

extension ValueWrapper: Sendable where T: Sendable { }
