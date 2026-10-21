//
//  View+Rounded.swift
//  CoreUI
//

import SwiftUI

extension View {

    public func rounded(_ radius: CornerRadius) -> ModifiedContent<Self, RoundedCornersModifier> {
        modifier(RoundedCornersModifier(radius: radius.rawValue))
    }
}
