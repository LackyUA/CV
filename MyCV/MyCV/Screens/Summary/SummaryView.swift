//
//  SummaryView.swift
//  MyCV
//

import SwiftUI

struct SummaryView: View {

    @State private var viewModel = SummaryViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ScreenHeaderImage(name: "summary")
                    .background(Color.white)

                SummaryText(paragraphs: viewModel.paragraphs)
            }
        }
        .background(Color(.accent))
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
        VStack(alignment: .leading, spacing: 15) {
            ForEach(paragraphs) { paragraph in
                Text(paragraph.text)
            }
        }
        .font(.custom("GillSans-Italic", size: 17))
        .foregroundStyle(.white)
        .lineSpacing(5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
    }

}

#Preview {
    SectionSheet {
        SummaryView()
    }
}
