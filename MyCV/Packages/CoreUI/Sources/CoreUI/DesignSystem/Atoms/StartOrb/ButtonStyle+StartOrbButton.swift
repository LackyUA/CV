//
//  ButtonStyle+StartOrbButton.swift
//  CoreUI
//

import SwiftUI

extension ButtonStyle where Self == StartOrbButtonStyle {

    /// A button style that shows the button as a round Liquid Glass orb.
    public static var startOrb: StartOrbButtonStyle {
        .init(
            default: .init(
                foregroundColor: Colors.neonCyan.swiftUIColor,
                tintColor: .clear,
                glow: .glowCyan
            ),
            pressed: .init(
                foregroundColor: Colors.neonCyan.swiftUIColor,
                tintColor: Colors.glassTintCyan.swiftUIColor,
                glow: .glowCyan
            )
        )
    }
}
