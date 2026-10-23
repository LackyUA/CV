//
//  SummaryLoadedViewConfiguration.swift
//  MyCV
//

import Core
import CoreUI
import SwiftUI

struct SummaryLoadedViewConfiguration: Equatable {

    /// A group of cards under a header.
    struct Section: Equatable, Identifiable {

        /// The identifier of the group. The raw value is the position of the group on the screen.
        let id: UniqueIdentifier<Self, Int>

        /// The header above the cards, such as `Profile`.
        let title: String

        /// The cards of the group, from top to bottom.
        let entries: [Entry]
    }

    /// A card for the profile paragraph or for one highlight.
    struct Entry: Equatable, Identifiable {

        /// The identifier of the card. The raw value is the position of the card in its group.
        let id: UniqueIdentifier<Self, Int>

        /// The text of the card.
        let card: EntryCardConfiguration
    }

    /// The title of the navigation bar.
    let title: String

    /// The illustration at the top of the screen.
    let headerImage: Image

    /// The groups of cards, from top to bottom.
    let sections: [Section]
}
