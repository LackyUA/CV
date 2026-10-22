//
//  SummaryView.swift
//  MyCV
//

import CoreUI
import Services
import SwiftUI

struct SummaryView: View {

    init(viewModel: SummaryViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ScreenHeaderImage(asset: Images.summary)

                SummaryText(paragraphs: viewModel.paragraphs)
            }
        }
        .sectionNavigationBar(title: viewModel.title)
    }

    // MARK: - Private Properties

    @State private var viewModel: SummaryViewModel

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
    NavigationStack {
        SummaryView(
            viewModel: SummaryViewModel(
                summary: Summary(
                    title: "Profile",
                    description: "A short overview of my experience, stack, and achievements.",
                    profile: "Senior iOS Engineer with 8+ years in production apps.",
                    highlights: [
                        "Migrated production codebases from UIKit/RxSwift to SwiftUI and Swift Concurrency.",
                        "Shipped on-device image classification in a banking onboarding flow.",
                    ]
                )
            )
        )
    }
    .tint(Colors.textPrimary.swiftUIColor)
}
