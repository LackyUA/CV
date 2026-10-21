//
//  View+Border.swift
//  CoreUI
//
//  Created by Serhii Yelmanov on 07.07.2025.
//

import SwiftUI

extension View {

    /// Draws a border around this view using the view's provided source shape.
    ///
    /// - Parameters:
    ///   - color: The color of the border stroke.
    ///   - lineWidth: The width of the border line.
    ///   - isEnabled: A Boolean value that controls whether the border is visible. Defaults to `true`.
    public func border<SourceShape: Shape>(
        color: Color, lineWidth: BorderLineWidth, isEnabled: Bool = true
    ) -> ModifiedContent<Self, BorderModifier<SourceShape>> where Self: SourceShapeProviding<SourceShape> {
        modifier(
            BorderModifier(color: color, borderShape: self.sourceShape, lineWidth: lineWidth, isEnabled: isEnabled)
        )
    }
}

public struct BorderModifier<S: Shape>: ViewModifier {

    public func body(content: Content) -> some View {
        content
            .overlay(
                borderShape
                    .stroke(color, lineWidth: lineWidth.rawValue)
                    .opacity(isEnabled ? 1.0 : 0.0)
            )
    }

    // MARK: - Properties

    let color: Color, borderShape: S, lineWidth: BorderLineWidth, isEnabled: Bool
}

extension BorderModifier: SourceShapeProviding {

    public nonisolated var sourceShape: S {
        borderShape
    }
}
