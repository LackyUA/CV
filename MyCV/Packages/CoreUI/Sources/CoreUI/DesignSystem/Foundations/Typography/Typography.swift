//
//  Typography.swift
//  CoreUI
//

import SwiftUI

/// Typesetting information for displayed text.
public struct Typography: Sendable {

    /// Creates a typography style from the given values.
    init(
        font: UIFont,
        weight: Font.Weight,
        textStyle: Font.TextStyle = .body,
        lineHeight: CGFloat,
        tracking: CGFloat = 0,
        isUppercased: Bool = false,
    ) {
        self.font = font
        self.weight = .init(weight)
        self.swiftUiWeight = weight
        self.textStyle = textStyle
        self.lineHeight = lineHeight
        self.lineHeightMultiple = lineHeight / font.lineHeight
        self.tracking = tracking
        self.isUppercased = isUppercased
    }

    /// The font of the typography style.
    let font: UIFont

    /// The weight of the font.
    let weight: UIFont.Weight

    /// The SwiftUI representation of `weight`.
    let swiftUiWeight: Font.Weight

    /// The dynamic text style that scales the font. The default value is `body`.
    let textStyle: Font.TextStyle

    /// The line height in points.
    let lineHeight: CGFloat

    /// The multiplier that converts the default line height of `font` to `lineHeight`.
    let lineHeightMultiple: CGFloat

    /// The extra space between characters in points. The value is the design-system `letterSpacing` in em
    /// multiplied by the font size.
    let tracking: CGFloat

    /// A Boolean value that indicates whether the text renders in uppercase. Display and HUD styles use uppercase.
    let isUppercased: Bool
}
