//
//  SummaryView.swift
//  MyCV
//

import CoreUI
import Services
import SwiftUI

/// Shows the summary screen for the current state of the view model.
///
/// In the loaded state, the screen shows an entry card for the profile paragraph and for each highlight.
struct SummaryView: View {

    init(viewModel: SummaryViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - View

    var body: some View {
        ZStack {
            Colors.bg100.swiftUIColor
                .ignoresSafeArea()

            switch viewModel.state {
            case .idle:
                EmptyView()
            case .loaded(let currentState):
                SummaryLoadedView(configuration: currentState.configuration)
            }
        }
        .onAppear {
            viewModel.initiate()
        }
    }

    // MARK: - Private Properties

    @State
    private var viewModel: SummaryViewModel
}

#Preview {
    NavigationStack {
        SummaryView(
            viewModel: SummaryViewModel(
                summary: Summary(
                    title: "Summary",
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
