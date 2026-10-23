//
//  SummaryLoadedView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows a scrollable list of entry cards for the profile paragraph and the highlights over the header illustration.
///
/// The illustration is a fixed background at the top of the screen, under the navigation bar.
/// The cards start below the illustration and scroll over it.
/// The cards are in groups. Each group has a header above its cards.
struct SummaryLoadedView: View {

    let configuration: SummaryLoadedViewConfiguration

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

                                VStack(spacing: Spacing.xs) {
                                    ForEach(section.entries) { entry in
                                        EntryCard(configuration: entry.card)
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
        SummaryLoadedView(
            configuration: .init(
                title: "Summary",
                headerImage: Image(decorative: Images.summary),
                sections: [
                    .init(
                        id: .init(rawValue: 0),
                        title: "Profile",
                        entries: [
                            .init(
                                id: .init(rawValue: 0),
                                card: .init(description: "Senior iOS Engineer with 8+ years in production apps.")
                            ),
                        ]
                    ),
                    .init(
                        id: .init(rawValue: 1),
                        title: "Selected Engineering Highlights",
                        entries: [
                            .init(
                                id: .init(rawValue: 0),
                                card: .init(
                                    description: "Migrated production codebases from UIKit/RxSwift to SwiftUI."
                                )
                            ),
                            .init(
                                id: .init(rawValue: 1),
                                card: .init(description: "Shipped on-device image classification in a banking onboarding flow.")
                            ),
                        ]
                    ),
                ]
            )
        )
    }
    .tint(Colors.textPrimary.swiftUIColor)
}
