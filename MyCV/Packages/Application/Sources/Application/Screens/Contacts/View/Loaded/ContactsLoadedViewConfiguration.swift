//
//  ContactsLoadedViewConfiguration.swift
//  MyCV
//

import Core
import CoreUI
import SwiftUI

struct ContactsLoadedViewConfiguration: Equatable {

    /// A card of contact rows under a header.
    struct Section: Equatable, Identifiable {

        /// The identifier of the card. The raw value is the position of the card on the screen.
        let id: UniqueIdentifier<Self, Int>

        /// The header above the card, such as `Contact`.
        let title: String

        /// The rows of the card, from top to bottom.
        let rows: [Row]
    }

    /// A row for one contact, such as the phone number.
    struct Row: Equatable, Identifiable {

        /// The identifier of the row. The raw value is the position of the contact in the CV.
        let id: UniqueIdentifier<Self, Int>

        /// The caption, the value, and the icon of the row.
        let row: ContactRowConfiguration

        /// The actions of the menu that opens when the user taps the row, from top to bottom.
        let actions: [Action]
    }

    /// An item of the menu of a row, such as `Copy`.
    struct Action: Equatable, Identifiable {

        /// The identifier of the item. The raw value is the position of the item in the menu.
        let id: UniqueIdentifier<Self, Int>

        /// The title of the item.
        let title: String

        /// The icon of the item.
        let image: Image

        /// Does the action of the item.
        @NullEquatable
        var perform: () -> Void
    }

    /// The title of the navigation bar.
    let title: String

    /// The illustration at the top of the screen.
    let headerImage: Image

    /// The cards of contact rows, from top to bottom.
    let sections: [Section]
}
