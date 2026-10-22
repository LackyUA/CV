//
//  ExperienceDetailsViewModel.swift
//  MyCV
//

import Foundation
import Observation

/// Presents one experience item and opens its project link.
@MainActor
@Observable
final class ExperienceDetailsViewModel {

    init(item: ExperienceItem) {
        self.item = item
    }

    /// Controls the alert that explains that the project has no public link.
    var showsUnavailableAlert = false

    var title: String { item.title }
    var period: String { item.period }
    var description: String { item.description }

    /// Link to the project page or repository, or `nil` when the project has no public link.
    var projectURL: URL? {
        guard !item.link.isEmpty else { return nil }
        return URL(string: item.link)
    }

    /// Opens the project link. Shows the unavailable alert when there is no link.
    func openProject(open: (URL) -> Void) {
        guard let projectURL else {
            showsUnavailableAlert = true
            return
        }
        open(projectURL)
    }

    // MARK: - Private Properties

    private let item: ExperienceItem

}
