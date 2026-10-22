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

    init(service: APIService, router: any Router<ExperienceRouter.Route>) {
        self.service = service
        self.router = router
    }

    private(set) var title = ""
    private(set) var items: [ExperienceItem] = []

    func load() async {
        do {
            let experience = try await service.fetchContent().experience
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
        } catch {
            print(error)
        }
    }

    /// Pushes the details screen of the selected item.
    func select(_ item: ExperienceItem) {
        router.push(.details(item))
    }

    // MARK: - Private Properties

    private let service: APIService
    private let router: any Router<ExperienceRouter.Route>

}
