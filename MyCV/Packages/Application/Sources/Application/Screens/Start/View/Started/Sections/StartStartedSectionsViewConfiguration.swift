//
//  StartStartedSectionsViewConfiguration.swift
//  MyCV
//

import Core

struct StartStartedSectionsViewConfiguration: Equatable {

    /// A section button.
    struct Section: Equatable, Identifiable {

        /// The identifier of the button. The raw value is the position of the section in the CV.
        let id: UniqueIdentifier<Self, Int>

        /// The title of the button.
        let title: String

        /// Opens the section.
        @NullEquatable
        var select: () -> Void
    }

    /// The section buttons, from top to bottom.
    let sections: [Section]
}
