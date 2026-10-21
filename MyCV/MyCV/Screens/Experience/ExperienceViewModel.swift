//
//  ExperienceViewModel.swift
//  MyCV
//

import Foundation
import Observation

@MainActor
@Observable
final class ExperienceViewModel {

    private(set) var title = ""
    private(set) var items: [ExperienceItem] = []

    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

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

}
