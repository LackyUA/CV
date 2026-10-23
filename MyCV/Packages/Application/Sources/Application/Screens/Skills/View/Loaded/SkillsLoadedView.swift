//
//  SkillsLoadedView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows a scrollable list with an entry card for each group of skills over the header illustration.
///
/// The illustration is a fixed background at the top of the screen, under the navigation bar.
/// The cards start below the illustration and scroll over it.
/// Each card shows the name of its group and the skills of the group, separated by commas.
struct SkillsLoadedView: View {

    let configuration: SkillsLoadedViewConfiguration

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

                    VStack(spacing: Spacing.xs) {
                        ForEach(configuration.sections) { section in
                            EntryCard(configuration: section.card)
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
        SkillsLoadedView(
            configuration: .init(
                title: "Skills",
                headerImage: Image(decorative: Images.skills),
                sections: [
                    .init(id: .init(rawValue: 0), card: .init(title: "Languages", description: "Swift, Python")),
                    .init(id: .init(rawValue: 1), card: .init(title: "UI", description: "SwiftUI, UIKit, Atomic Design")),
                ]
            )
        )
    }
    .tint(Colors.textPrimary.swiftUIColor)
}
