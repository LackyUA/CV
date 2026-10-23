//
//  StartStartedSectionsView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows a scrollable list with an entry card for each section of the CV.
///
/// Each card shows the title and the description of its section.
struct StartStartedSectionsView: View {

    let configuration: StartStartedSectionsViewConfiguration

    // MARK: - View

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.xs) {
                ForEach(configuration.sections) { section in
                    Button {
                        section.select()
                    } label: {
                        EntryCard(configuration: section.card)
                    }
                    .buttonStyle(.entryCard)
                }
            }
            .padding(.horizontal, Spacing.m)
            .padding(.vertical, Spacing.s)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    StartStartedSectionsView(
        configuration: .init(
            sections: [
                .init(
                    id: .init(rawValue: 0),
                    card: .init(
                        title: "Contacts",
                        description: "Ways to reach me: my location, e-mail address, and phone number."
                    ),
                    select: {}
                ),
                .init(
                    id: .init(rawValue: 1),
                    card: .init(
                        title: "Profile",
                        description: "A short overview of my experience and main technology stack."
                    ),
                    select: {}
                ),
                .init(
                    id: .init(rawValue: 2),
                    card: .init(
                        title: "Skills",
                        description: "The languages, frameworks, and tools that I use, grouped by area."
                    ),
                    select: {}
                ),
            ]
        )
    )
    .background(Colors.bg200.swiftUIColor)
}
