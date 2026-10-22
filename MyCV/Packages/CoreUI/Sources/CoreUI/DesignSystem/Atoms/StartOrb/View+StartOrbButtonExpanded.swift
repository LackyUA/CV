//
//  View+StartOrbButtonExpanded.swift
//  CoreUI
//

import SwiftUI

extension View {

    /// Sets whether start orb buttons in this view expand and fade out.
    ///
    /// An expanded orb grows to four times its size and fades into the background.
    /// It does not receive taps and is hidden from accessibility.
    /// Change the value in an animation to animate the change.
    ///
    /// - Parameter isExpanded: A Boolean value that indicates whether the orb expands and fades out.
    public nonisolated func startOrbButtonExpanded(_ isExpanded: Bool) -> some View {
        environment(\.startOrbButtonExpanded, isExpanded)
    }
}

extension EnvironmentValues {

    @Entry
    var startOrbButtonExpanded = false
}
