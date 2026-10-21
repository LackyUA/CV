//
//  BoxShadowElevation.swift
//  CoreUI
//

import SwiftUI

// swiftlint:disable identifier_name

/// A representation of shadow elevation used for custom shadow styling.
public struct BoxShadowElevation {

    /// The color of the shadow.
    public let color: Color

    /// The blur radius of the shadow.
    public let radius: CGFloat

    /// The spread of the shadow. Positive values increase size, negative values shrink it.
    public let spread: CGFloat

    /// The horizontal offset of the shadow.
    public let x: CGFloat

    /// The vertical offset of the shadow.
    public let y: CGFloat
}

// swiftlint:enable identifier_name

extension BoxShadowElevation {

    /// A predefined small shadow style.
    public static var small: BoxShadowElevation {
        .init(color: .black.opacity(0.13), radius: 2, spread: 0, x: 0, y: 1)
    }

    /// A predefined medium shadow style.
    public static var medium: BoxShadowElevation {
        .init(color: .black.opacity(0.1), radius: 3, spread: 0, x: 0, y: 1)
    }

    /// A predefined large shadow style.
    public static var large: BoxShadowElevation {
        .init(color: .black.opacity(0.1), radius: 7, spread: -2, x: 0, y: 4)
    }

    /// Zero shadow style.
    public static var zero: BoxShadowElevation {
        .init(color: .clear, radius: 0, spread: 0, x: 0, y: 0)
    }
}
