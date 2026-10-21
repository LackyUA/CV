//
//  View+Blur.swift
//  CoreUI
//

import SwiftUI

extension View {

    /// Blurs the content of the view, for example ambient glow blobs behind glass.
    ///
    /// - Parameters:
    ///   - radius: The design-system blur radius.
    ///   - opaque: Whether the blur renders an opaque result. Defaults to `false`.
    public func blur(_ radius: BlurRadius, opaque: Bool = false) -> some View {
        blur(radius: radius.swiftUiRadius, opaque: opaque)
    }

    /// Fills the source shape of the view with a backdrop blur and an optional tint.
    ///
    /// Use it as the base of a Liquid Glass surface. Apply it after a modifier that provides a shape:
    /// ```swift
    /// content
    ///     .rounded(.xl)
    ///     .backgroundBlur(.regular, tint: Colors.glassFill.swiftUIColor)
    ///     .border(color: Colors.glassStroke.swiftUIColor, lineWidth: .m)
    ///     .boxShadow(.glass)
    /// ```
    /// If Reduce Transparency is on, the modifier fills the shape with `GlassFillOpaque` instead of the blur.
    ///
    /// - Parameters:
    ///   - radius: The design-system blur radius; picks the closest system material.
    ///   - tint: An optional color layered over the blur (for example `GlassFill` or `GlassTintCyan`).
    public func backgroundBlur<SourceShape: Shape>(
        _ radius: BlurRadius, tint: Color? = nil
    ) -> ModifiedContent<Self, BackgroundBlurModifier<SourceShape>> where Self: SourceShapeProviding<SourceShape> {
        modifier(BackgroundBlurModifier(radius: radius, tint: tint, blurShape: self.sourceShape))
    }
}

public struct BackgroundBlurModifier<S: Shape>: ViewModifier {

    // MARK: - ViewModifier

    public func body(content: Content) -> some View {
        content
            .background {
                if reduceTransparency {
                    blurShape.fill(Colors.glassFillOpaque.swiftUIColor)
                } else {
                    ZStack {
                        if radius.rawValue > 0 {
                            blurShape.fill(radius.material)
                        }
                        if let tint {
                            blurShape.fill(tint)
                        }
                    }
                }
            }
    }

    // MARK: - Properties

    init(radius: BlurRadius, tint: Color?, blurShape: S) {
        self.radius = radius
        self.tint = tint
        self.blurShape = blurShape
    }

    let radius: BlurRadius, tint: Color?, blurShape: S

    // MARK: - Private Properties

    @Environment(\.accessibilityReduceTransparency)
    private var reduceTransparency
}

extension BackgroundBlurModifier: SourceShapeProviding {

    public nonisolated var sourceShape: S {
        blurShape
    }
}
