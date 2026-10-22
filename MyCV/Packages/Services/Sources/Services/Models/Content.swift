//
//  Content.swift
//  Services
//

/// The full CV content. Each property is one section of `Content.json`.
public struct Content: Decodable, Equatable, Sendable {

    /// The contact details, such as the e-mail address and the profile links.
    public let contacts: Contacts

    /// The profile text and the engineering highlights.
    public let summary: Summary

    /// The skills, grouped into titled sections.
    public let skills: Skills

    /// The school, the university degree, and the courses.
    public let education: Education

    /// The job positions, from the most recent to the oldest.
    public let experience: Experience

    /// The hobbies, the languages, and the community membership.
    public let additional: Additional
}
