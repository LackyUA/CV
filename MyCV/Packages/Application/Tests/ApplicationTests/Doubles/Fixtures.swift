//
//  Fixtures.swift
//  ApplicationTests
//

import Services

/// Literal CV sections for tests.
enum Fixtures {

    static let skills: ContentSection = .skills(
        Skills(title: "Skills", description: "", sections: [.init(title: "Languages", items: ["Swift"])])
    )

    static let education: ContentSection = .education(
        Education(
            title: "Education",
            description: "",
            school: "School",
            university: .init(name: "University", direction: "Direction", qualification: "Master", years: "2012–2019", gpa: "4.91"),
            courses: []
        )
    )

    static let experience: ContentSection = .experience(
        Experience(title: "Experience", description: "", positions: [])
    )

    static let content = Content(sections: [skills, education, experience])
}
