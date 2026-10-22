//
//  CachedTransformer.swift
//  Core
//
//  Created by Andrii Vysotskyi on 29.04.2026.
//

/// A transformer that caches successful outputs for repeated input/context pairs.
public final class CachedTransformer<Base>: TopLevelTransformer where Base: TopLevelTransformer {

    public init(base: Base, countLimit: Int = 10_000) where Base.Input: Hashable, Base.Context: Hashable {
        self.base = base
        makeKey = { input, context in
            AnyHashable(Key(input: input, context: context))
        }
        cache.totalCostLimit = countLimit
    }

    public init(base: Base, countLimit: Int = 10_000) where Base.Input: Hashable, Base.Context == Void {
        self.base = base
        makeKey = { input, _ in
            AnyHashable(input)
        }
        cache.totalCostLimit = countLimit
    }

    // MARK: - TopLevelTransformer

    public func transform(_ input: Base.Input, context: Base.Context) throws(Base.Failure) -> Base.Output {
        let key = makeKey(input, context)
        if let output = cache.value(forKey: key) {
            return output
        }
        let output = try base.transform(input, context: context)
        cache.insert(output, forKey: key, cost: 1)
        return output
    }

    // MARK: - Private Types

    private struct Key<Input: Hashable, Context: Hashable>: Hashable {
        let input: Input, context: Context
    }

    // MARK: - Private Properties

    private let base: Base
    private let cache = Cache<AnyHashable, Output>()
    private let makeKey: (Input, Context) -> AnyHashable
}

extension TopLevelTransformer where Input: Hashable, Context: Hashable {

    /// Returns a transformer that caches successful outputs for repeated input/context pairs.
    public var cached: CachedTransformer<Self> {
        CachedTransformer(base: self)
    }
}

extension TopLevelTransformer where Input: Hashable, Context == Void {

    /// Returns a transformer that caches successful outputs for repeated inputs.
    public var cached: CachedTransformer<Self> {
        CachedTransformer(base: self)
    }
}
