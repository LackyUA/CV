//
//  MathUtils.swift
//  Core
//
//  Created by Andrii Vysotskyi on 29.08.2025.
//

import SwiftUI

/// Clamps a value to the given range.
public func clamp<T: Comparable>(value: T, min: T, max: T) -> T {
    Swift.max(Swift.min(value, max), min)
}

/// Clamps a value to the given bounds range.
public func clamp<T: Comparable>(value: T, to bounds: ClosedRange<T>) -> T {
    clamp(value: value, min: bounds.lowerBound, max: bounds.upperBound)
}

/// Maps a value linearly to the normalized range `0...1`.
///
/// Values at or below `x` return `0`, values at or above `y` return `1`,
/// and values between the bounds are linearly interpolated.
public func inverseLerp<T: BinaryFloatingPoint>(_ value: T, from min: T, to max: T) -> T {
    clamp(value: (value - min) / (max - min), min: 0, max: 1)
}
