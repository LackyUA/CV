//
//  SkillsView.swift
//  MyCV
//

import CoreUI
import Services
import SwiftUI

struct SkillsView: View {

    init(viewModel: SkillsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeaderImage(asset: Images.skills)

            List {
                ForEach(viewModel.sections) { section in
                    Section {
                        ForEach(section.skills) { skill in
                            SkillRow(name: skill.name)
                        }
                    } header: {
                        SkillsSectionHeader(title: section.title)
                    }
                }
            }
            .listStyle(.plain)
        }
        .sectionNavigationBar(title: viewModel.title)
    }

    // MARK: - Private Properties

    @State private var viewModel: SkillsViewModel

}

// MARK: - Rows

private struct SkillRow: View {

    let name: String

    var body: some View {
        Text(name)
            .typography(.Interface.body)
            .padding(.vertical, Spacing.s)
    }

}

/// Neon section title with hairline separators.
private struct SkillsSectionHeader: View {

    let title: String

    var body: some View {
        Text(title)
            .typography(.Display.sectionTitle)
            .foregroundStyle(Colors.neonCyan.swiftUIColor)
            .textCase(nil)
            .padding(.horizontal, Spacing.m)
            .padding(.vertical, Spacing.xxs)
            .frame(maxWidth: .infinity, minHeight: 35, alignment: .leading)
            .background(Colors.bg100.swiftUIColor)
            .overlay(alignment: .top) {
                Colors.hairline.swiftUIColor.frame(height: 0.4)
            }
            .overlay(alignment: .bottom) {
                Colors.hairline.swiftUIColor.frame(height: 0.4)
            }
            .listRowInsets(EdgeInsets())
    }

}

#Preview {
    NavigationStack {
        SkillsView(
            viewModel: SkillsViewModel(
                skills: Skills(
                    title: "Skills",
                    sections: [
                        .init(title: "Languages", items: ["Swift", "Python"]),
                        .init(title: "UI", items: ["SwiftUI", "UIKit", "Atomic Design"]),
                    ]
                )
            )
        )
    }
    .tint(Colors.textPrimary.swiftUIColor)
}
