//
//  ButtonStyle+EntryCard.swift
//  CoreUI
//

import SwiftUI

extension ButtonStyle where Self == EntryCardButtonStyle {

    /// A button style that makes an ``EntryCard`` in the label selectable.
    public static var entryCard: EntryCardButtonStyle {
        .init(
            default: .init(
                tintColor: nil,
                strokeColor: Colors.glassStroke.swiftUIColor,
                glow: .glass,
                isInteractive: true,
                showsDisclosureIndicator: true
            ),
            pressed: .init(
                tintColor: Colors.glassTintCyan.swiftUIColor,
                strokeColor: Colors.glassStroke.swiftUIColor,
                glow: .glass,
                isInteractive: true,
                showsDisclosureIndicator: true
            ),
            selected: .init(
                tintColor: Colors.glassTintCyan.swiftUIColor,
                strokeColor: Colors.neonCyan.swiftUIColor,
                glow: .glowCyan,
                isInteractive: true,
                showsDisclosureIndicator: true
            )
        )
    }
}
