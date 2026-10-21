//
//  SkillsView.swift
//  MyCV
//

import SwiftUI

struct SkillsView: View {

    @State private var viewModel = SkillsViewModel()

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeaderImage(name: "skills")

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
            .padding(.vertical, 12)
    }

}

/// Blue band with a white italic title and thin separators, matching the previous section header view.
private struct SkillsSectionHeader: View {

    let title: LocalizedStringResource

    var body: some View {
        Text(title)
            .font(.custom("GillSans-Italic", size: 20))
            .foregroundStyle(.white)
            .textCase(nil)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, minHeight: 35, alignment: .leading)
            .background(Color(.accent))
            .overlay(alignment: .top) {
                Color(.lightGray).frame(height: 0.4)
            }
            .overlay(alignment: .bottom) {
                Color(.lightGray).frame(height: 0.4)
            }
            .listRowInsets(EdgeInsets())
    }

}

#Preview {
    SectionSheet {
        SkillsView()
    }
}
