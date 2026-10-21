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

                SummaryText(paragraphs: viewModel.paragraphs)
            }
        }
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
                    .typography(.Interface.body)
            }
        }
        .foregroundStyle(Colors.textPrimary.swiftUIColor)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.l)
        .rounded(.xxl)
        .backgroundBlur(.thick, tint: Colors.glassFill.swiftUIColor)
        .border(color: Colors.glassStroke.swiftUIColor, lineWidth: .m)
        .boxShadow(.glass)
        .padding(.horizontal, Spacing.m)
    }

}

#Preview {
    SectionSheet {
        SummaryView()
    }
}
