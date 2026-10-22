//
//  StartStartedSectionsViewConfiguration.swift
//  MyCV
//

import Core

struct StartStartedSectionsViewConfiguration: Equatable {

    /// A section button.
    struct Section: Equatable, Identifiable {

        /// The identifier of the section that the button opens.
        let id: UniqueIdentifier<Self, CVSection>

        /// The title of the button.
        let title: String

        /// Opens the section.
        @NullEquatable
        var select: () -> Void
    }

    /// The section buttons, from top to bottom.
    let sections: [Section]
}
