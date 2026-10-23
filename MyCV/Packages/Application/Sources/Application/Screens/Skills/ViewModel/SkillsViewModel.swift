//
//  SkillsViewModel.swift
//  MyCV
//

import CoreUI
import Observation
import Services
import SwiftUI

/// Keeps the state of the skills screen.
///
/// The screen starts in the idle state. `initiate()` changes it to the loaded state,
/// which shows an entry card for each group of skills.
@MainActor
@Observable
final class SkillsViewModel {

    init(skills: Skills) {
        self.skills = skills
        state = .idle
    }

    /// The current state of the screen.
    private(set) var state: SkillsViewModelState

    /// Shows the groups of skills.
    ///
    /// The method has an effect only in the idle state. Thus, the screen keeps its state when it appears again.
    func initiate() {
        guard case .idle = state else {
            return
        }
        state = .loaded(.init(configuration: loadedConfiguration()))
    }

    // MARK: - Private Properties

    private let skills: Skills

    // MARK: - Private Methods

    private func loadedConfiguration() -> SkillsLoadedViewConfiguration {
        .init(
            title: skills.title,
            headerImage: Image(decorative: Images.skills),
            sections: skills.sections.enumerated().map { index, section in
                .init(
                    id: .init(rawValue: index),
                    card: .init(title: section.title, description: section.items.joined(separator: ", "))
                )
            }
        )
    }
}
