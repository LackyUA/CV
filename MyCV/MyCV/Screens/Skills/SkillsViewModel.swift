//
//  SkillsViewModel.swift
//  MyCV
//

import Foundation
import Observation

@MainActor
@Observable
final class SkillsViewModel {

    struct Skill: Identifiable, Equatable {
        let id: Int
        let name: String
    }

    struct SkillsSection: Identifiable, Equatable {
        let id: String
        let title: LocalizedStringResource
        let skills: [Skill]
    }

    private(set) var title = ""
    private(set) var sections: [SkillsSection] = []

    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    func load() async {
        do {
            let skills = try await service.fetch(Skills.self)
            title = skills.title
            sections = [
                makeSection(id: "languages", title: "Languages", names: skills.languages),
                makeSection(id: "embedded", title: "Embedded frameworks", names: skills.embeddedFrameworks),
                makeSection(id: "thirdParty", title: "Third party frameworks", names: skills.thirdPartyFrameworks),
                makeSection(id: "patterns", title: "Design patterns", names: skills.designPatterns),
                makeSection(id: "systems", title: "Operation systems", names: skills.operationSystems)
            ]
        } catch {
            print(error)
        }
    }

    private func makeSection(id: String, title: LocalizedStringResource, names: [String]) -> SkillsSection {
        let skills = names.enumerated().map { index, name in
            Skill(id: index, name: name)
        }
        return SkillsSection(id: id, title: title, skills: skills)
    }

}
