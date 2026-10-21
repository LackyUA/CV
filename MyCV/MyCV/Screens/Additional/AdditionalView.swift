//
//  AdditionalView.swift
//  MyCV
//

import CoreUI
import SwiftUI

struct AdditionalView: View {

    @State private var viewModel = AdditionalViewModel()

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
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(title)
                .typography(.Heading.Level3.bold)
            Text(value)
                .typography(.Paragraph.Level1.regular)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

}

#Preview {
    SectionSheet {
        AdditionalView()
    }
}
