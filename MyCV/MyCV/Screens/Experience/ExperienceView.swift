//
//  ExperienceView.swift
//  MyCV
//

import SwiftUI

struct ExperienceView: View {

    @State private var viewModel = ExperienceViewModel()

    var body: some View {
        List {
            ScreenHeaderImage(name: "experience")
                .plainListHeaderRow()

            ForEach(viewModel.items) { item in
                NavigationLink(value: item) {
                    Text(item.title)
                        .padding(.vertical, 8)
                }
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: ExperienceItem.self) { item in
            ExperienceDetailsView(item: item)
        }
        .sectionNavigationBar(title: viewModel.title)
        .task {
            await viewModel.load()
        }
    }

}

#Preview {
    SectionSheet {
        ExperienceView()
    }
}
