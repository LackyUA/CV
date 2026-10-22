//
//  Contacts.swift
//  Services
//

/// The contact details of the CV.
public struct Contacts: Decodable, Equatable, Sendable {

    /// The title of the section, as the screen shows it.
    public let title: String

    /// The city and country of residence.
    public let address: String

    /// The e-mail address.
    public let email: String

    /// The mobile phone number in international format, such as `+380668422448`.
    public let mobile: String

    /// The URL of the GitHub profile.
    public let git: String

    /// The URL of the LinkedIn profile.
    public let linkedin: String
}
