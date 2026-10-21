//
//  View+BoxShadow.swift
//  CoreUI
//

import SwiftUI

// swiftlint:disable identifier_name

extension View {

    /// Adds a shadow to this view.
    func boxShadow(
        color: Color,
        radius: CGFloat,
        shape: some SpreadableShape,
        spread: CGFloat = 0,
        x: CGFloat = 0,
        y: CGFloat = 0
    ) -> some View {
        background(
            _ShadowView(
                shape: shape.spread(by: spread),
                effect: _ShadowEffect(color: color, radius: radius, offset: .init(width: x, height: y))
            )
        )
    }

    /// Adds a shadow to this view. The shadow uses the source shape of the view.
    func boxShadow<ClipShape: SpreadableShape>(
        color: Color, radius: CGFloat, spread: CGFloat = 0, x: CGFloat = 0, y: CGFloat = 0
    ) -> some View where Self: SourceShapeProviding<ClipShape> {
        boxShadow(color: color, radius: radius, shape: self.sourceShape, spread: spread, x: x, y: y)
    }
}

// swiftlint:enable identifier_name
