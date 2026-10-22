//
//  ContactsViewModel.swift
//  MyCV
//

import Foundation
import Observation
import Services

@MainActor
@Observable
final class ContactsViewModel {

    /// One line of the contacts list. Rows with an `action` are tappable.
    struct Row: Identifiable, Equatable {
        enum Action: Equatable {
            case call(number: String)
            case open(url: URL)
        }

        /// Trailing icon shown for tappable rows.
        enum Icon: Equatable {
            case call
            case web
        }

        let id: String
        let title: LocalizedStringResource
        let details: String
        let icon: Icon?
        let action: Action?
    }

    init(contacts: Contacts) {
        title = contacts.title
        rows = Self.makeRows(from: contacts)
    }

    let title: String
    let rows: [Row]

    // MARK: - Private Methods

    private static func makeRows(from contacts: Contacts) -> [Row] {
        [
            Row(id: "address", title: "Address", details: contacts.address, icon: nil, action: nil),
            Row(id: "email", title: "E-mail", details: contacts.email, icon: nil, action: nil),
            Row(id: "mobile", title: "Mobile", details: contacts.mobile, icon: .call, action: .call(number: contacts.mobile)),
            Row(id: "github", title: "GitHub", details: contacts.git, icon: .web, action: openAction(for: contacts.git)),
            Row(id: "linkedin", title: "LinkedIn", details: contacts.linkedin, icon: .web, action: openAction(for: contacts.linkedin))
        ]
    }

    private static func openAction(for link: String) -> Row.Action? {
        guard !link.isEmpty, let url = URL(string: link) else { return nil }
        return .open(url: url)
    }

}
