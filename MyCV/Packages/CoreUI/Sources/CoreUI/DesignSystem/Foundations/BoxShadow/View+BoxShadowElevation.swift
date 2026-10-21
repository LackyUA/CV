//
//  View+BoxShadowElevation.swift
//  CoreUI
//
//  Created by Andrii Vysotskyi on 25.06.2025.
//

import SwiftUI

extension View {

    /// Applies a shadow to the view with a specified `BoxShadowElevation` and custom `SpreadableShape`.
    public func boxShadow(
        elevation: BoxShadowElevation = .large, shape: some SpreadableShape,
    ) -> some View {
        boxShadow(
            color: elevation.color,
            radius: elevation.radius,
            shape: shape,
            spread: elevation.spread,
            x: elevation.x,
            y: elevation.y
        )
    }

    /// Applies a shadow to the view using a `BoxShadowElevation`, automatically inferring its shape from source view.
    public func boxShadow<ClipShape: SpreadableShape>(
        elevation: BoxShadowElevation = .large
    ) -> some View where Self: SourceShapeProviding<ClipShape> {
        boxShadow(elevation: elevation, shape: self.sourceShape)
    }
}
