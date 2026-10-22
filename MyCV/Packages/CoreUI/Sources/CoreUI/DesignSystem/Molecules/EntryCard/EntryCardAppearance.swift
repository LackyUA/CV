//
//  EntryCardAppearance.swift
//  CoreUI
//

import SwiftUI

/// The appearance of an ``EntryCard`` in one interaction state.
struct EntryCardAppearance: Sendable {

    /// The color of the glass, or `nil` for glass without a tint.
    let tintColor: Color?

    /// The color of the rim around the card.
    let strokeColor: Color

    /// The glow around the card.
    let glow: BoxShadow

    /// A Boolean value that indicates whether the native glass reacts to touches.
    let isInteractive: Bool

    /// A Boolean value that indicates whether the card shows a disclosure chevron.
    let showsDisclosureIndicator: Bool
}

extension EntryCardAppearance {

    /// The appearance of a static card, which the user cannot select.
    static var plain: EntryCardAppearance {
        .init(
            tintColor: nil,
            strokeColor: Colors.glassStroke.swiftUIColor,
            glow: .glass,
            isInteractive: false,
            showsDisclosureIndicator: false
        )
    }
}

extension EnvironmentValues {

    /// The appearance that ``EntryCardButtonStyle`` gives the card in its label.
    ///
    /// Outside the button style, the value is `nil`. A card without an appearance is static.
    @Entry
    var entryCardAppearance: EntryCardAppearance? = nil // swiftlint:disable:this redundant_optional_initialization
}
