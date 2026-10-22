//
//  ExperienceViewModel.swift
//  MyCV
//

import Foundation
import Observation
import Services

@MainActor
@Observable
final class ExperienceViewModel {

    init(experience: Experience, router: any Router<ExperienceRouter.Route>) {
        self.router = router
        title = experience.title
        items = experience.positions.enumerated().map { index, position in
            ExperienceItem(
                id: index,
                title: position.name,
                period: position.period,
                link: position.link,
                description: position.description
            )
        }
    }

    let title: String
    let items: [ExperienceItem]

    /// Pushes the details screen of the selected item.
    func select(_ item: ExperienceItem) {
        router.push(.details(item))
    }

    // MARK: - Private Properties

    private let router: any Router<ExperienceRouter.Route>

}
