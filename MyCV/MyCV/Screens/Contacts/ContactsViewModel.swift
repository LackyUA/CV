//
//  ContactsViewModel.swift
//  MyCV
//

import Foundation
import Observation

@MainActor
@Observable
final class ContactsViewModel {

    /// One line of the contacts list. Rows with an `action` are tappable.
    struct Row: Identifiable, Equatable {
        enum Action: Equatable {
            case call(number: String)
            case open(url: URL)
        }

        let id: String
        let title: LocalizedStringResource
        let details: String
        let iconName: String?
        let action: Action?
    }

    private(set) var title = ""
    private(set) var rows: [Row] = []

    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    func load() async {
        do {
            let contacts = try await service.fetch(Contacts.self)
            title = contacts.title
            rows = Self.makeRows(from: contacts)
        } catch {
            print(error)
        }
    }

    private static func makeRows(from contacts: Contacts) -> [Row] {
        [
            Row(id: "address", title: "Address", details: contacts.address, iconName: nil, action: nil),
            Row(id: "email", title: "E-mail", details: contacts.email, iconName: nil, action: nil),
            Row(id: "skype", title: "Skype", details: contacts.skype, iconName: nil, action: nil),
            Row(id: "mobile", title: "Mobile", details: contacts.mobile, iconName: "call", action: .call(number: contacts.mobile)),
            Row(id: "github", title: "Github", details: contacts.git, iconName: "web", action: openAction(for: contacts.git)),
            Row(id: "facebook", title: "Facebook", details: contacts.facebook, iconName: "web", action: openAction(for: contacts.facebook))
        ]
    }

    private static func openAction(for link: String) -> Row.Action? {
        guard !link.isEmpty, let url = URL(string: link) else { return nil }
        return .open(url: url)
    }

}
