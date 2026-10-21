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

    /// Controls the alert that explains that the project code is not public.
    var showsUnavailableAlert = false

    var title: String { item.title }
    var period: String { item.period }
    var description: String { item.description }

    /// Link to the project repository, or `nil` when the code is not public.
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
