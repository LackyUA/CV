//
//  SummaryViewModel.swift
//  MyCV
//

import CoreUI
import Observation
import Services
import SwiftUI

/// Keeps the state of the summary screen.
///
/// The screen starts in the idle state. `initiate()` changes it to the loaded state,
/// which shows an entry card for the profile paragraph and for each highlight.
@MainActor
@Observable
final class SummaryViewModel {

    init(summary: Summary) {
        self.summary = summary
        state = .idle
    }

    /// The current state of the screen.
    private(set) var state: SummaryViewModelState

    /// Shows the profile paragraph and the highlights.
    ///
    /// The method has an effect only in the idle state. Thus, the screen keeps its state when it appears again.
    func initiate() {
        guard case .idle = state else {
            return
        }
        state = .loaded(.init(configuration: loadedConfiguration()))
    }

    // MARK: - Private Properties

    private let summary: Summary

    // MARK: - Private Methods

    /// Builds the profile group with the profile paragraph first, then the highlights group with a card for each
    /// highlight.
    private func loadedConfiguration() -> SummaryLoadedViewConfiguration {
        let profileSection = SummaryLoadedViewConfiguration.Section(
            id: .init(rawValue: 0),
            title: Constants.profileTitle,
            entries: [.init(id: .init(rawValue: 0), card: .init(description: summary.profile))]
        )
        let highlightsSection = SummaryLoadedViewConfiguration.Section(
            id: .init(rawValue: 1),
            title: Constants.highlightsTitle,
            entries: summary.highlights.enumerated().map { index, highlight in
                .init(id: .init(rawValue: index), card: .init(description: highlight))
            }
        )
        return .init(
            title: summary.title,
            headerImage: Image(decorative: Images.summary),
            sections: [profileSection, highlightsSection]
        )
    }

    // MARK: - Constants

    private enum Constants {

        /// The header of the profile group.
        static let profileTitle = "Profile"

        /// The header of the highlights group.
        static let highlightsTitle = "Selected Engineering Highlights"
    }
}
