//
//  View+Rounded.swift
//  CoreUI
//
//  Created by Serhii Yelmanov on 29.05.2025.
//

import SwiftUI

extension View {

    public func rounded(_ radius: CornerRadius) -> ModifiedContent<Self, RoundedCornersModifier> {
        modifier(RoundedCornersModifier(radius: radius.rawValue))
    }
}
