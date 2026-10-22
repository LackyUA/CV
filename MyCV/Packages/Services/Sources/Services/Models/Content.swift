//
//  Content.swift
//  Services
//

/// The full CV content of `Content.json`.
public struct Content: Decodable, Hashable, Sendable {

    /// Creates the CV content.
    public init(sections: [ContentSection]) {
        self.sections = sections
    }

    /// The sections of the CV, in the order that the start screen shows them.
    public let sections: [ContentSection]
}
