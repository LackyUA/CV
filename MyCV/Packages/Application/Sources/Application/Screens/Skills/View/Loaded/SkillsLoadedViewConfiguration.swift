//
//  SkillsLoadedViewConfiguration.swift
//  MyCV
//

import Core
import SwiftUI

struct SkillsLoadedViewConfiguration: Equatable {

    /// A card for one group of skills.
    struct Section: Equatable, Identifiable {

        /// The identifier of the card. The raw value is the position of the group in the CV.
        let id: UniqueIdentifier<Self, Int>

        /// The name of the group, such as `Languages`.
        let title: String

        /// The skills of the group, separated by commas.
        let description: String
    }

    /// The title of the navigation bar.
    let title: String

    /// The illustration at the top of the screen.
    let headerImage: Image

    /// The cards of the skill groups, from top to bottom.
    let sections: [Section]
}
