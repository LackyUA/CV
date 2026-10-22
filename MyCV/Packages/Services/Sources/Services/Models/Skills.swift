//
//  Skills.swift
//  Services
//

/// The skill groups of the CV.
public struct Skills: Decodable, Hashable, Sendable {

    /// One titled group of skills. Sections keep the order of the CV.
    public struct Section: Decodable, Hashable, Sendable {

        /// Creates a group of skills.
        public init(title: String, items: [String]) {
            self.title = title
            self.items = items
        }

        /// The name of the group, such as `Languages` or `Architecture`.
        public let title: String

        /// The skills of the group, in CV order.
        public let items: [String]
    }

    /// Creates the skill groups.
    public init(title: String, sections: [Section]) {
        self.title = title
        self.sections = sections
    }

    /// The title of the section, as the screen shows it.
    public let title: String

    /// The skill groups, in CV order.
    public let sections: [Section]
}
