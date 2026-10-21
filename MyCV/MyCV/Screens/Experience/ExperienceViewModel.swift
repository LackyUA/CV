//
//  ExperienceViewModel.swift
//  MyCV
//

import Foundation
import Observation

@MainActor
@Observable
final class ExperienceViewModel {

    init(service: APIServiceProtocol = APIService(), router: any Router<ExperienceRouter.Route>) {
        self.service = service
        self.router = router
    }

    private(set) var title = ""
    private(set) var items: [ExperienceItem] = []

    func load() async {
        do {
            let experience = try await service.fetch(Experience.self)
            title = experience.title
            items = experience.iosDeveloping.enumerated().map { index, entry in
                ExperienceItem(
                    id: index,
                    title: entry["name"] ?? "",
                    period: entry["period"] ?? "",
                    link: entry["link"] ?? "",
                    description: entry["description"] ?? ""
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

    private let service: APIServiceProtocol
    private let router: any Router<ExperienceRouter.Route>

}
