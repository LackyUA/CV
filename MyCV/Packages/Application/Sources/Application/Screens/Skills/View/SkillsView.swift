//
//  SkillsView.swift
//  MyCV
//

import CoreUI
import Services
import SwiftUI

/// Shows the skills screen for the current state of the view model.
///
/// In the loaded state, the screen shows an entry card for each group of skills.
struct SkillsView: View {

    init(viewModel: SkillsViewModel) {
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
                SkillsLoadedView(configuration: currentState.configuration)
            }
        }
        .onAppear {
            viewModel.initiate()
        }
    }

    // MARK: - Private Properties

    @State
    private var viewModel: SkillsViewModel
}

#Preview {
    NavigationStack {
        SkillsView(
            viewModel: SkillsViewModel(
                skills: Skills(
                    title: "Skills",
                    description: "The tools that I use, grouped by area.",
                    sections: [
                        .init(title: "Languages", items: ["Swift", "Python"]),
                        .init(title: "UI", items: ["SwiftUI", "UIKit", "Atomic Design"]),
                    ]
                )
            )
        )
    }
    .tint(Colors.textPrimary.swiftUIColor)
}
