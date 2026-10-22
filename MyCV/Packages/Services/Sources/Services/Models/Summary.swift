//
//  Summary.swift
//  Services
//

/// The profile text of the CV.
public struct Summary: Decodable, Hashable, Sendable {

    /// Creates the profile text.
    public init(title: String, description: String, profile: String, highlights: [String]) {
        self.title = title
        self.description = description
        self.profile = profile
        self.highlights = highlights
    }

    /// The title of the section, as the screen shows it.
    public let title: String

    /// A short text of one to three sentences that tells what the section contains.
    public let description: String

    /// The profile paragraph: years of experience, main stack, and key achievements.
    public let profile: String

    /// Selected engineering highlights, one bullet each, in CV order.
    public let highlights: [String]
}
