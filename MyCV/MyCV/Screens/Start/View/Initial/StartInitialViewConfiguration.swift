//
//  StartInitialViewConfiguration.swift
//  MyCV
//

import Core

struct StartInitialViewConfiguration: Equatable {

    /// The configuration of the welcome title.
    let title: StartInitialTitleViewConfiguration

    /// The title of the start orb.
    let startButtonTitle: String

    /// A Boolean value that indicates whether the start orb expands and the title moves off the screen.
    let isStarting: Bool

    /// Expands the start orb and then shows the sections menu.
    @NullEquatable
    var start: () -> Void
}
