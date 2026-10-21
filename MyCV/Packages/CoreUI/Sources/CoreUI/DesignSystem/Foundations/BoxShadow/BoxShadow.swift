//
//  BoxShadow.swift
//  CoreUI
//

import SwiftUI

/// A stack of shadow layers that matches a `box-shadow` list in the design system.
///
/// Design-system blur values use CSS pixels. The SwiftUI radius of each layer is half of the CSS value.
public struct BoxShadow {

    /// Layers drawn back to front.
    public let layers: [BoxShadowElevation]
}

extension BoxShadow {

    /// `shadow-glass` — soft lift under every glass surface (`0 10px 30px rgba(0,0,0,0.45)`).
    ///
    /// The inset highlight lines of `shadow-glass` are not shadows.
    /// Draw them on the glass surface with `GlassHighlight`.
    public static var glass: BoxShadow {
        .init(layers: [
            .init(color: .black.opacity(0.45), radius: 15, spread: 0, x: 0, y: 10),
        ])
    }

    /// `glow-cyan` — neon halo for the active or selected element and the main action.
    public static var glowCyan: BoxShadow {
        .glow(Colors.neonCyan.swiftUIColor, inner: (0.55, 6), outer: (0.25, 16))
    }

    /// `glow-magenta` — halo for pressed/hot states and the profile ring.
    public static var glowMagenta: BoxShadow {
        .glow(Colors.neonMagenta.swiftUIColor, inner: (0.55, 6), outer: (0.25, 16))
    }

    /// `glow-orange` — rare warm emphasis.
    public static var glowOrange: BoxShadow {
        .glow(Colors.neonOrange.swiftUIColor, inner: (0.5, 5), outer: (0.2, 13))
    }

    // MARK: - Private Methods

    private static func glow(
        _ color: Color, inner: (opacity: Double, radius: CGFloat), outer: (opacity: Double, radius: CGFloat)
    ) -> BoxShadow {
        .init(layers: [
            .init(color: color.opacity(outer.opacity), radius: outer.radius, spread: 0, x: 0, y: 0),
            .init(color: color.opacity(inner.opacity), radius: inner.radius, spread: 0, x: 0, y: 0),
        ])
    }
}
