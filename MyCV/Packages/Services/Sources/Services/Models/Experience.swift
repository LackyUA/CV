//
//  Experience.swift
//  Services
//

/// The job entries of the CV.
public struct Experience: Decodable, Equatable, Sendable {

    /// One job, from the most recent to the oldest.
    public struct Position: Decodable, Equatable, Sendable {

        /// The company and the job title, such as `Loca · Senior iOS Developer`.
        public let name: String

        /// The employment period, such as `Feb 2024 – Feb 2026`.
        public let period: String

        /// The public page of the project, or an empty string when the project has no public link.
        public let link: String

        /// The location, the team, the responsibilities, the project, and the technologies.
        /// Paragraphs are separated by blank lines.
        public let description: String
    }

    /// The title of the section, as the screen shows it.
    public let title: String

    /// The job positions, from the most recent to the oldest.
    public let positions: [Position]
}
