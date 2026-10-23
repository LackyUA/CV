//
//  ContactsViewModel.swift
//  MyCV
//

import Core
import CoreUI
import Foundation
import Observation
import Services
import SwiftUI

/// Keeps the state of the contacts screen and does the actions of the contact rows.
///
/// The screen starts in the idle state. `initiate()` changes it to the loaded state, which shows a card for the
/// contact details and a card for the profiles. Each row has a menu. All rows can copy their value. The mobile row
/// can also start a call, and the profile rows can also open the profile.
@MainActor
@Observable
final class ContactsViewModel {

    init(contacts: Contacts, systemActions: any SystemActions = DefaultSystemActions()) {
        self.contacts = contacts
        self.systemActions = systemActions
        state = .idle
    }

    /// The current state of the screen.
    private(set) var state: ContactsViewModelState

    /// Shows the contact cards.
    ///
    /// The method has an effect only in the idle state. Thus, the screen keeps its state when it appears again.
    func initiate() {
        guard case .idle = state else {
            return
        }
        state = .loaded(.init(configuration: loadedConfiguration()))
    }

    // MARK: - Private Properties

    private let contacts: Contacts

    private let systemActions: any SystemActions

    // MARK: - Private Methods

    private func loadedConfiguration() -> ContactsLoadedViewConfiguration {
        .init(
            title: contacts.title,
            headerImage: Image(decorative: Images.contact),
            sections: [
                .init(
                    id: .init(rawValue: 0),
                    title: Constants.contactTitle,
                    rows: rows(for: [.address, .email, .mobile])
                ),
                .init(id: .init(rawValue: 1), title: Constants.profilesTitle, rows: rows(for: [.git, .linkedin])),
            ]
        )
    }

    private func rows(for fields: [Field]) -> [ContactsLoadedViewConfiguration.Row] {
        fields.map { field in
            .init(
                id: .init(rawValue: field.rawValue),
                row: .init(title: field.title, value: displayValue(of: field), icon: field.icon),
                actions: actions(for: field)
            )
        }
    }

    /// Builds the menu of a row. The first item copies the value. The second item starts a call or opens the
    /// profile, if the row has a valid URL.
    private func actions(for field: Field) -> [ContactsLoadedViewConfiguration.Action] {
        var actions: [ContactsLoadedViewConfiguration.Action] = [
            .init(
                id: .init(rawValue: 0),
                title: Constants.copyTitle,
                image: Image(systemName: Constants.copySymbolName),
                perform: { [weak self] in
                    self?.copy(field)
                }
            ),
        ]
        if url(of: field) != nil, let title = field.openTitle, let symbolName = field.openSymbolName {
            actions.append(
                .init(
                    id: .init(rawValue: 1),
                    title: title,
                    image: Image(systemName: symbolName),
                    perform: { [weak self] in
                        self?.open(field)
                    }
                )
            )
        }
        return actions
    }

    private func copy(_ field: Field) {
        systemActions.copy(value(of: field))
    }

    private func open(_ field: Field) {
        guard let url = url(of: field) else {
            return
        }
        systemActions.open(url)
    }

    private func value(of field: Field) -> String {
        switch field {
        case .address:
            contacts.address
        case .email:
            contacts.email
        case .mobile:
            contacts.mobile
        case .git:
            contacts.git
        case .linkedin:
            contacts.linkedin
        }
    }

    /// Returns the text that the row shows.
    ///
    /// The mobile row shows the number in the format of `Constants.phoneMask`. If the number does not agree with
    /// the mask, the row shows the number without a change. A profile row shows its URL without the scheme, the
    /// `www.` prefix, and the trailing slash.
    private func displayValue(of field: Field) -> String {
        let value = value(of: field)
        switch field {
        case .address, .email:
            return value
        case .mobile:
            return value.applyingMask(Constants.phoneMask) ?? value
        case .git, .linkedin:
            return Self.shortLink(value)
        }
    }

    /// Returns the URL that the second menu item opens, or `nil` if the row has no such URL.
    private func url(of field: Field) -> URL? {
        let value = value(of: field)
        switch field {
        case .address, .email:
            return nil
        case .mobile:
            let number = value.filter { $0 == "+" || $0.isNumber }
            return number.isEmpty ? nil : URL(string: Constants.phoneScheme + number)
        case .git, .linkedin:
            guard let url = URL(string: value), url.scheme != nil, url.host() != nil else {
                return nil
            }
            return url
        }
    }

    private static func shortLink(_ link: String) -> String {
        var result = Substring(link)
        if let schemeRange = result.range(of: "://") {
            result = result[schemeRange.upperBound...]
        }
        if result.hasPrefix(Constants.wwwPrefix) {
            result = result.dropFirst(Constants.wwwPrefix.count)
        }
        while result.hasSuffix("/") {
            result = result.dropLast()
        }
        return String(result)
    }

    // MARK: - Field

    /// A contact of the CV. The raw value is the position of the contact in the CV.
    private enum Field: Int {
        case address, email, mobile, git, linkedin

        /// The caption of the row.
        var title: String {
            switch self {
            case .address:
                "Address"
            case .email:
                "E-mail"
            case .mobile:
                "Mobile"
            case .git:
                "GitHub"
            case .linkedin:
                "LinkedIn"
            }
        }

        /// The icon at the trailing edge of the row, or `nil` for a row without an icon.
        var icon: Image? {
            switch self {
            case .address, .email:
                nil
            case .mobile:
                Image(decorative: Images.call)
            case .git, .linkedin:
                Image(decorative: Images.web)
            }
        }

        /// The title of the second menu item, or `nil` for a row that can only copy its value.
        var openTitle: String? {
            switch self {
            case .address, .email:
                nil
            case .mobile:
                "Call"
            case .git, .linkedin:
                "Open"
            }
        }

        /// The SF Symbol of the second menu item, or `nil` for a row that can only copy its value.
        var openSymbolName: String? {
            switch self {
            case .address, .email:
                nil
            case .mobile:
                "phone"
            case .git, .linkedin:
                "safari"
            }
        }
    }

    // MARK: - Constants

    private enum Constants {

        /// The header of the card with the address, the e-mail address, and the phone number.
        static let contactTitle = "Contact"

        /// The header of the card with the GitHub and LinkedIn profiles.
        static let profilesTitle = "Profiles"

        /// The title of the menu item that copies the value of a row.
        static let copyTitle = "Copy"

        /// The SF Symbol of the menu item that copies the value of a row.
        static let copySymbolName = "doc.on.doc"

        /// The format of the phone number. Each `#` is one digit.
        static let phoneMask = "+380 (##) #### ###"

        /// The scheme of the URL that starts a call.
        static let phoneScheme = "tel:"

        /// The host prefix that a profile row does not show.
        static let wwwPrefix = "www."
    }
}
