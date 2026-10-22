//
//  MyCVTests.swift
//  MyCVTests
//

import Services
import Testing
@testable import MyCV

/// Decodes the bundled `Content.json` to catch schema drift between the data and the models.
struct ContentDecodingTests {

    @Test
    func contentDecodes() async throws {
        let content = try await ServiceBuilder.makeAPIService().fetchContent()

        #expect(content.contacts.title == "Contacts")
        #expect(!content.contacts.email.isEmpty)
        #expect(!content.contacts.linkedin.isEmpty)

        #expect(content.summary.title == "Profile")
        #expect(!content.summary.description.isEmpty)
        #expect(!content.summary.highlights.isEmpty)

        #expect(content.skills.title == "Skills")
        #expect(content.skills.sections.first?.title == "Languages")
        #expect(content.skills.sections.allSatisfy { !$0.items.isEmpty })

        #expect(content.education.title == "Education")
        #expect(!content.education.university.name.isEmpty)

        #expect(content.experience.title == "Experience")
        #expect(!content.experience.positions.isEmpty)
        #expect(content.experience.positions.allSatisfy { !$0.name.isEmpty && !$0.period.isEmpty })

        #expect(content.additional.title == "Additional information")
        #expect(!content.additional.english.isEmpty)
        #expect(!content.additional.ukrainian.isEmpty)
    }

}
