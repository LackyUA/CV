//
//  ExperienceView.swift
//  MyCV
//

import CoreUI
import SwiftUI

struct ExperienceView: View {

    @State private var viewModel = ExperienceViewModel()

    var body: some View {
        List {
            ScreenHeaderImage(asset: Images.experience)
                .plainListHeaderRow()

            ForEach(viewModel.items) { item in
                NavigationLink(value: item) {
                    Text(item.title)
                        .typography(.Interface.body)
                        .padding(.vertical, Spacing.xs)
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
