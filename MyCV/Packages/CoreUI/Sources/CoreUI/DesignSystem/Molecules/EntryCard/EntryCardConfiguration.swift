//
//  EntryCardConfiguration.swift
//  CoreUI
//

/// The text that an ``EntryCard`` shows.
///
/// A configuration has a title, a description, or both. The card shows the text without localization.
/// Resolve localized text into a `String` before you create the configuration.
public struct EntryCardConfiguration: Equatable, Sendable {

    /// Creates a configuration with a title and an optional description.
    ///
    /// - Parameters:
    ///   - title: The title of the card.
    ///   - description: The text under the title. The default value is `nil`, which shows the title only.
    public init(title: String, description: String? = nil) {
        self.title = title
        self.description = description
    }

    /// Creates a configuration without a title.
    ///
    /// - Parameter description: The body text of the card.
    public init(description: String) {
        title = nil
        self.description = description
    }

    /// The title of the card. The value is `nil` for a card that shows only its description.
    public let title: String?

    /// The body text of the card. The value is `nil` for a card that shows only its title.
    public let description: String?
}
