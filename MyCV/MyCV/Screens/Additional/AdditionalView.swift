//
//  AdditionalView.swift
//  MyCV
//

import SwiftUI

struct AdditionalView: View {

    @State private var viewModel = AdditionalViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ScreenHeaderImage(name: "additional")

                ForEach(viewModel.entries) { entry in
                    AdditionalEntryView(title: entry.title, value: entry.value)
                        .padding(.horizontal, 20)
                }
            }
            .padding(.bottom, 20)
        }
        .sectionNavigationBar(title: viewModel.title)
        .task {
            await viewModel.load()
        }
    }

}

// MARK: - Entry

private struct AdditionalEntryView: View {

    let title: LocalizedStringResource
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
            Text(value)
                .font(.body)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

}

#Preview {
    SectionSheet {
        AdditionalView()
    }
}
