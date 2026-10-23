//
//  StartStartedSectionsViewConfiguration.swift
//  MyCV
//

import Core
import CoreUI

struct StartStartedSectionsViewConfiguration: Equatable {

    /// A section card.
    struct Section: Equatable, Identifiable {

        /// The identifier of the card. The raw value is the position of the section in the CV.
        let id: UniqueIdentifier<Self, Int>

        /// The title of the section and the text under it, which tells what the section contains.
        let card: EntryCardConfiguration

        /// Opens the section.
        @NullEquatable
        var select: () -> Void
    }

    /// The section cards, from top to bottom.
    let sections: [Section]
}
