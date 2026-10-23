//
//  ContactsLoadedView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows a scrollable list of contact cards over the header illustration.
///
/// The illustration is a fixed background at the top of the screen, under the navigation bar.
/// The cards start below the illustration and scroll over it. Each card has a header above it.
/// When the user taps a row, a menu with the actions of the row opens.
struct ContactsLoadedView: View {

    let configuration: ContactsLoadedViewConfiguration

    // MARK: - View

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    // A hidden copy of the illustration keeps the first card below the visible one.
                    // The illustration starts at the top edge of the screen, and the scroll content starts
                    // below the navigation bar. Thus, the copy is shorter by the top safe area inset.
                    headerImage
                        .hidden()
                        .padding(.top, -geometry.safeAreaInsets.top)

                    VStack(spacing: Spacing.l) {
                        ForEach(configuration.sections) { section in
                            VStack(alignment: .leading, spacing: Spacing.s) {
                                Text(verbatim: section.title)
                                    .typography(.Display.sectionTitle)
                                    .foregroundStyle(Colors.textSecondary.swiftUIColor)
                                    .padding(.horizontal, Spacing.m)
                                    .accessibilityAddTraits(.isHeader)

                                ContactCard {
                                    ForEach(section.rows) { row in
                                        Menu {
                                            ForEach(row.actions) { action in
                                                Button {
                                                    action.perform()
                                                } label: {
                                                    Label {
                                                        Text(verbatim: action.title)
                                                    } icon: {
                                                        action.image
                                                    }
                                                }
                                            }
                                        } label: {
                                            ContactRow(configuration: row.row)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, Spacing.m)
                    .padding(.vertical, Spacing.s)
                }
            }
            .scrollIndicators(.hidden)
            .background(alignment: .top) {
                headerImage
                    .ignoresSafeArea(edges: .top)
            }
        }
        .sectionNavigationBar(title: configuration.title, barBackground: .hidden)
    }

    // MARK: - Private Properties

    private var headerImage: some View {
        configuration.headerImage
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        ContactsLoadedView(
            configuration: .init(
                title: "Contacts",
                headerImage: Image(decorative: Images.contact),
                sections: [
                    .init(
                        id: .init(rawValue: 0),
                        title: "Contact",
                        rows: [
                            .init(
                                id: .init(rawValue: 0),
                                row: .init(title: "Address", value: "Ivano-Frankivsk, Ukraine"),
                                actions: [
                                    .init(
                                        id: .init(rawValue: 0),
                                        title: "Copy",
                                        image: Image(systemName: "doc.on.doc"),
                                        perform: {}
                                    ),
                                ]
                            ),
                            .init(
                                id: .init(rawValue: 1),
                                row: .init(
                                    title: "Mobile",
                                    value: "+380 (00) 0000 000",
                                    icon: Image(decorative: Images.call)
                                ),
                                actions: [
                                    .init(
                                        id: .init(rawValue: 0),
                                        title: "Copy",
                                        image: Image(systemName: "doc.on.doc"),
                                        perform: {}
                                    ),
                                    .init(
                                        id: .init(rawValue: 1),
                                        title: "Call",
                                        image: Image(systemName: "phone"),
                                        perform: {}
                                    ),
                                ]
                            ),
                        ]
                    ),
                    .init(
                        id: .init(rawValue: 1),
                        title: "Profiles",
                        rows: [
                            .init(
                                id: .init(rawValue: 0),
                                row: .init(
                                    title: "GitHub",
                                    value: "github.com/LackyUA",
                                    icon: Image(decorative: Images.web)
                                ),
                                actions: [
                                    .init(
                                        id: .init(rawValue: 0),
                                        title: "Open",
                                        image: Image(systemName: "safari"),
                                        perform: {}
                                    ),
                                ]
                            ),
                        ]
                    ),
                ]
            )
        )
    }
    .tint(Colors.textPrimary.swiftUIColor)
}
