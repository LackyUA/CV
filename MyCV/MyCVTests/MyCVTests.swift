//
//  MyCVTests.swift
//  MyCVTests
//

import Services
import Testing

/// Decodes the bundled `Content.json` to catch schema drift between the data and the models.
struct ContentDecodingTests {

    @Test
    func contentDecodes() async throws {
        let content = try await ServiceBuilder.makeAPIService().fetchContent()

        #expect(content.sections.map(\.title) == [
            "Contacts",
            "Summary",
            "Skills",
            "Education",
            "Experience",
            "Additional information",
        ])

        for section in content.sections {
            switch section {
            case .contacts(let contacts):
                #expect(!contacts.email.isEmpty)
                #expect(!contacts.linkedin.isEmpty)
            case .summary(let summary):
                #expect(!summary.description.isEmpty)
                #expect(!summary.highlights.isEmpty)
            case .skills(let skills):
                #expect(skills.sections.first?.title == "Languages")
                #expect(skills.sections.allSatisfy { !$0.items.isEmpty })
            case .education(let education):
                #expect(!education.university.name.isEmpty)
            case .experience(let experience):
                #expect(!experience.positions.isEmpty)
                #expect(experience.positions.allSatisfy { !$0.name.isEmpty && !$0.period.isEmpty })
            case .additional(let additional):
                #expect(!additional.english.isEmpty)
                #expect(!additional.ukrainian.isEmpty)
            }
        }
    }

}
