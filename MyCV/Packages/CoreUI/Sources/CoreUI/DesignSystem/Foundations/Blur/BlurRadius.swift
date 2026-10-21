//
//  BlurRadius.swift
//  CoreUI
//

import SwiftUI

/// Blur radius symbols from the `blur` tokens of the design system.
///
/// Raw values use design-system (CSS) pixels. The blur modifiers convert these values to SwiftUI radii.
public struct BlurRadius: RawRepresentable, Sendable {

    public init(rawValue: CGFloat) {
        self.rawValue = rawValue
    }

    public let rawValue: CGFloat
}

extension BlurRadius {

    /// No blur.
    public static let zero = BlurRadius(rawValue: 0)

    /// 12 pt. The `blur-glass-thin` token for small controls, such as navigation buttons and segmented thumbs.
    public static let thin = BlurRadius(rawValue: 12)

    /// 24 pt. The `blur-glass` token. Use it as the default for cards, capsules, and bars.
    public static let regular = BlurRadius(rawValue: 24)

    /// 40 pt. The `blur-glass-thick` token for sheets and large panels over busy illustrations.
    public static let thick = BlurRadius(rawValue: 40)
}

extension BlurRadius {

    /// SwiftUI radius equivalent of the design-system value.
    var swiftUiRadius: CGFloat {
        rawValue / 2
    }

    /// The system material that is closest to this radius. The backdrop blur uses this material.
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
