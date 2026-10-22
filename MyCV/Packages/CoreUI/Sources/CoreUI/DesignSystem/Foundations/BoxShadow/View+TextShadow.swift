//
//  View+TextShadow.swift
//  CoreUI
//

import SwiftUI

extension View {

    /// Applies every layer of a `BoxShadow` to the content of the view, for example a neon glow on text.
    ///
    /// Use this modifier for content without a source shape, such as `Text`.
    /// For shapes, use `boxShadow(_:)`. This modifier ignores the `spread` value of each layer.
    public func textShadow(_ shadow: BoxShadow) -> some View {
        modifier(TextShadowModifier(layers: shadow.layers))
    }
}

private struct TextShadowModifier: ViewModifier {

    let layers: [BoxShadowElevation]

    func body(content: Content) -> some View {
        layers.reduce(AnyView(content)) { view, layer in
            AnyView(view.shadow(color: layer.color, radius: layer.radius, x: layer.x, y: layer.y))
        }
    }
}
