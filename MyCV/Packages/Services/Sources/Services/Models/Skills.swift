//
//  Skills.swift
//  Services
//

/// The skill groups of the CV.
public struct Skills: Decodable, Equatable, Sendable {

    /// One titled group of skills. Sections keep the order of the CV.
    public struct Section: Decodable, Equatable, Sendable {

        /// The name of the group, such as `Languages` or `Architecture`.
        public let title: String

        /// The skills of the group, in CV order.
        public let items: [String]
    }

    /// The title of the section, as the screen shows it.
    public let title: String

    /// The skill groups, in CV order.
    public let sections: [Section]
}
