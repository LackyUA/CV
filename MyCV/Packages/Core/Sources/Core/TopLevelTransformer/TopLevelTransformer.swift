//
//  TopLevelTransformer.swift
//  Core
//
//  Created by Andrii Vysotskyi on 30.01.2026.
//

// TODO: Ensure all transformations are based on TopLevelTransformer protocol for consistency

import Foundation

/// A top-level transformer that converts values of type `Input` into values of type `Output`.
///
/// This protocol defines the standard boundary transformation between layers,
/// e.g., repository models to service models. Conforming types should implement
/// the transformation as a pure, deterministic function.
///
/// - Note: `transform(_:)` may throw an error if the transformation fails.
public protocol TopLevelTransformer<Input, Output, Context, Failure> {

    /// The input type to transform.
    associatedtype Input

    /// The output type produced by the transformation.
    associatedtype Output

    /// Shared dependencies and environment for transforming an `Input`.
    associatedtype Context = Void

    /// The type of error that may be thrown during transformation.
    associatedtype Failure: Error = Never

    /// Transforms a value of type `Input` into a value of type `Output`.
    func transform(_ input: Input, context: Context) throws(Failure) -> Output
}

extension TopLevelTransformer where Context == Void {

    /// Transforms a value of type `Input` into a value of type `Output`.
    public func transform(_ input: Input) throws(Failure) -> Output {
        try transform(input, context: ())
    }
}
