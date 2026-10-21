//
//  Typography.swift
//  CoreUI
//
//  Created by Andrii Vysotskyi on 27.05.2025.
//

import SwiftUI

/// Holds typesetting information that could be applied to displayed text.
public struct Typography: Sendable {

    /// Creates typography with provided information.
    init(
        font: UIFont,
        weight: Font.Weight,
        textStyle: Font.TextStyle = .body,
        lineHeight: CGFloat,
    ) {
        self.font = font
        self.weight = .init(weight)
        self.swiftUiWeight = weight
        self.textStyle = textStyle
        self.lineHeight = lineHeight
        self.lineHeightMultiple = lineHeight / font.lineHeight
    }

    /// Font associated with given typography.
    let font: UIFont

    /// Weight of the font.
    let weight: UIFont.Weight

    /// The SwiftUI `Font` representation of the typography's weight.
    let swiftUiWeight: Font.Weight

    /// A dynamic text style to use for font. Default value is `body`.
    let textStyle: Font.TextStyle

    /// Line height. If not set explicitly equals to font's line height.
    let lineHeight: CGFloat

    /// The multiplier applied to the font's default line height to achieve the specified `lineHeight`.
    let lineHeightMultiple: CGFloat
}
