//
//  AdditionalView.swift
//  MyCV
//

import CoreUI
import Services
import SwiftUI

struct AdditionalView: View {

    init(viewModel: AdditionalViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.l) {
                ScreenHeaderImage(asset: Images.additional)

                ForEach(viewModel.entries) { entry in
                    AdditionalEntryView(title: entry.title, value: entry.value)
                        .padding(.horizontal, Spacing.l)
                }
            }
            .padding(.bottom, Spacing.l)
        }
        .sectionNavigationBar(title: viewModel.title)
    }

    // MARK: - Private Properties

    @State private var viewModel: AdditionalViewModel

}

// MARK: - Entry

private struct AdditionalEntryView: View {

    let title: LocalizedStringResource
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(title)
                .typography(.Interface.headline)
            Text(value)
                .typography(.Interface.body)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

}

#Preview {
    NavigationStack {
        AdditionalView(
            viewModel: AdditionalViewModel(
                additional: Additional(
                    title: "Additional information",
                    hobbies: ["Hill climbing", "Playing volleyball"],
                    english: "Upper-Intermediate",
                    ukrainian: "Native",
                    community: "Point-Free community member"
                )
            )
        )
    }
    .tint(Colors.textPrimary.swiftUIColor)
}
