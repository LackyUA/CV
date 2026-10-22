//
//  View+BackgroundGlass.swift
//  CoreUI
//

import SwiftUI

extension View {

    /// Fills the source shape of the view with Liquid Glass.
    ///
    /// On iOS 26 and later, the modifier uses the native Liquid Glass effect.
    /// On earlier versions, it uses a `regular` backdrop blur with the `GlassFill` tint.
    /// Apply it after a modifier that provides a shape:
    /// ```swift
    /// content
    ///     .rounded(.xl)
    ///     .backgroundGlass(tint: Colors.glassTintCyan.swiftUIColor, isInteractive: true)
    ///     .border(color: Colors.glassStroke.swiftUIColor, lineWidth: .m)
    ///     .boxShadow(.glass)
    /// ```
    ///
    /// - Parameters:
    ///   - tint: An optional color that the modifier gives the glass. The default value is `nil`.
    ///   - isInteractive: A Boolean value that indicates whether the native glass reacts to touches.
    ///     The default value is `false`. Earlier versions ignore this value.
    public func backgroundGlass<SourceShape: Shape>(
        tint: Color? = nil, isInteractive: Bool = false
    ) -> ModifiedContent<Self, BackgroundGlassModifier<SourceShape>> where Self: SourceShapeProviding<SourceShape> {
        modifier(BackgroundGlassModifier(tint: tint, isInteractive: isInteractive, glassShape: self.sourceShape))
    }
}

public struct BackgroundGlassModifier<S: Shape>: ViewModifier {

    // MARK: - ViewModifier

    public func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content
                .glassEffect(.regular.tint(tint).interactive(isInteractive), in: glassShape)
        } else {
            content
                .background {
                    if let tint {
                        glassShape.fill(tint)
                    }
                }
                .modifier(
                    BackgroundBlurModifier(radius: .regular, tint: Colors.glassFill.swiftUIColor, blurShape: glassShape)
                )
        }
    }

    // MARK: - Internal

    init(tint: Color?, isInteractive: Bool, glassShape: S) {
        self.tint = tint
        self.isInteractive = isInteractive
        self.glassShape = glassShape
    }

    let tint: Color?, isInteractive: Bool, glassShape: S
}

extension BackgroundGlassModifier: SourceShapeProviding {

    public nonisolated var sourceShape: S {
        glassShape
    }
}
