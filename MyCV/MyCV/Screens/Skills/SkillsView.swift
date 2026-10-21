//
//  SkillsView.swift
//  MyCV
//

import CoreUI
import SwiftUI

struct SkillsView: View {

    @State private var viewModel = SkillsViewModel()

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
        .task {
            await viewModel.load()
        }
    }

}

// MARK: - Rows

private struct SkillRow: View {

    let name: String

    var body: some View {
        Text(name)
            .typography(.Paragraph.Level1.regular)
            .padding(.vertical, Spacing.s)
    }

}

/// Blue band with a white italic title and thin separators, matching the previous section header view.
private struct SkillsSectionHeader: View {

    let title: LocalizedStringResource

    var body: some View {
        Text(title)
            .typography(.Quote.large)
            .foregroundStyle(.white)
            .textCase(nil)
            .padding(.horizontal, Spacing.m)
            .padding(.vertical, Spacing.xxs)
            .frame(maxWidth: .infinity, minHeight: 35, alignment: .leading)
            .background(Colors.accent.swiftUIColor)
            .overlay(alignment: .top) {
                Colors.lightGray.swiftUIColor.frame(height: 0.4)
            }
            .overlay(alignment: .bottom) {
                Colors.lightGray.swiftUIColor.frame(height: 0.4)
            }
            .listRowInsets(EdgeInsets())
    }

}

#Preview {
    SectionSheet {
        SkillsView()
    }
}
