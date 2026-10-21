//
//  BlurRadius.swift
//  CoreUI
//

import SwiftUI

/// Blur radius symbols from the `blur` tokens of the design system.
///
/// Raw values use design-system (CSS) pixels. The blur modifiers convert them to SwiftUI radii.
public struct BlurRadius: RawRepresentable, Sendable {

    public init(rawValue: CGFloat) {
        self.rawValue = rawValue
    }

    public let rawValue: CGFloat
}

extension BlurRadius {

    /// No blur.
    public static let zero = BlurRadius(rawValue: 0)

    /// 12 pt — `blur-glass-thin`: small controls (nav buttons, segmented thumb, dots pill).
    public static let thin = BlurRadius(rawValue: 12)

    /// 24 pt — `blur-glass`: default for cards, capsules and bars.
    public static let regular = BlurRadius(rawValue: 24)

    /// 40 pt — `blur-glass-thick`: large panels over busy illustrations, sheets.
    public static let thick = BlurRadius(rawValue: 40)
}

extension BlurRadius {

    /// SwiftUI radius equivalent of the design-system value.
    var swiftUiRadius: CGFloat {
        rawValue / 2
    }

    /// The system material closest to this radius, used for backdrop blur.
    var material: Material {
        switch rawValue {
        case ...BlurRadius.thin.rawValue:
            .ultraThinMaterial
        case ...BlurRadius.regular.rawValue:
            .thinMaterial
        default:
            .regularMaterial
        }
    }
}
