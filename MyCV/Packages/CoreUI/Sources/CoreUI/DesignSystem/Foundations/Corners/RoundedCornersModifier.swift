//
//  RoundedCornersModifier.swift
//  CoreUI
//

import SwiftUI

public struct RoundedCornersModifier: ViewModifier {

    public let radius: CGFloat

    // MARK: - ViewModifier

    public func body(content: Content) -> some View {
        // Recommended `clipShape` modifier is less efficient since incurs the performance
        // overhead of off-screen rendering. So corner radius is used instead.
        content.cornerRadius(radius)
    }
}

extension RoundedCornersModifier {

    public nonisolated var clipShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: radius)
    }
}
