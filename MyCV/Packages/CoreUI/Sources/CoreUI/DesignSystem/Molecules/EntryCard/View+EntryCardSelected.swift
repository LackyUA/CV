//
//  View+EntryCardSelected.swift
//  CoreUI
//

import SwiftUI

extension View {

    /// Sets whether entry card buttons in this view show the selected state.
    ///
    /// A selected card has a cyan tint, a cyan rim and a cyan glow. VoiceOver reads it as selected.
    /// When a card becomes selected, the device plays a selection haptic.
    ///
    /// - Parameter isSelected: A Boolean value that indicates whether the card is selected.
    public nonisolated func entryCardSelected(_ isSelected: Bool) -> some View {
        environment(\.entryCardSelected, isSelected)
    }
}

extension EnvironmentValues {

    /// A Boolean value that indicates whether entry card buttons show the selected state.
    @Entry
    var entryCardSelected = false
}
