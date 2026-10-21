//
//  View+BoxShadowLayers.swift
//  CoreUI
//

import SwiftUI

extension View {

    /// Applies every layer of a `BoxShadow` to the view using a custom `SpreadableShape`.
    public func boxShadow(_ shadow: BoxShadow, shape: some SpreadableShape) -> some View {
        background {
            ZStack {
                ForEach(shadow.layers.indices, id: \.self) { index in
                    Color.clear
                        .boxShadow(elevation: shadow.layers[index], shape: shape)
                }
            }
        }
    }

    /// Applies every layer of a `BoxShadow`, inferring its shape from the source view.
    public func boxShadow<ClipShape: SpreadableShape>(
        _ shadow: BoxShadow
    ) -> some View where Self: SourceShapeProviding<ClipShape> {
        boxShadow(shadow, shape: self.sourceShape)
    }
}
