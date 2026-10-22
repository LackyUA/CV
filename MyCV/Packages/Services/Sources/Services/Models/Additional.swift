//
//  Additional.swift
//  Services
//

/// The hobbies, languages, and community facts of the CV.
public struct Additional: Decodable, Hashable, Sendable {

    /// Creates the additional information.
    public init(title: String, hobbies: [String], english: String, ukrainian: String, community: String) {
        self.title = title
        self.hobbies = hobbies
        self.english = english
        self.ukrainian = ukrainian
        self.community = community
    }

    /// The title of the section, as the screen shows it.
    public let title: String

    /// The hobbies, in CV order.
    public let hobbies: [String]

    /// The level of English, such as `Upper-Intermediate`.
    public let english: String

    /// The level of Ukrainian, such as `Native`.
    public let ukrainian: String

    /// The community membership, such as `Point-Free community member`.
    public let community: String
}
