//
//  SkillsViewModel.swift
//  MyCV
//

import Foundation
import Observation
import Services

@MainActor
@Observable
final class SkillsViewModel {

    struct Skill: Identifiable, Equatable {
        let id: Int
        let name: String
    }

    struct SkillsSection: Identifiable, Equatable {
        let id: Int
        let title: String
        let skills: [Skill]
    }

    init(service: APIService) {
        self.service = service
    }

    private(set) var title = ""
    private(set) var sections: [SkillsSection] = []

    func load() async {
        do {
            let skills = try await service.fetchContent().skills
            title = skills.title
            sections = skills.sections.enumerated().map { index, section in
                Self.makeSection(id: index, from: section)
            }
        } catch {
            print(error)
        }
    }

    // MARK: - Private Properties

    private let service: APIService

    // MARK: - Private Methods

    private static func makeSection(id: Int, from section: Skills.Section) -> SkillsSection {
        let skills = section.items.enumerated().map { index, name in
            Skill(id: index, name: name)
        }
        return SkillsSection(id: id, title: section.title, skills: skills)
    }

}
