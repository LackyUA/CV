//
//  SummaryView.swift
//  MyCV
//

import CoreUI
import SwiftUI

struct SummaryView: View {

    @State private var viewModel = SummaryViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ScreenHeaderImage(asset: Images.summary)
                    .background(Color.white)

                SummaryText(paragraphs: viewModel.paragraphs)
            }
        }
        .background(Colors.accent.swiftUIColor)
        .sectionNavigationBar(title: viewModel.title)
        .task {
            await viewModel.load()
        }
    }

}

// MARK: - Text block

private struct SummaryText: View {

    let paragraphs: [SummaryViewModel.Paragraph]

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.m) {
            ForEach(paragraphs) { paragraph in
                Text(paragraph.text)
                    .typography(.Quote.small)
            }
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.l)
    }

}

#Preview {
    SectionSheet {
        SummaryView()
    }
}
