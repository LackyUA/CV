//
//  ExperienceView.swift
//  MyCV
//

import CoreUI
import Services
import SwiftUI

struct ExperienceView: View {

    init(viewModel: ExperienceViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ScreenHeaderImage(asset: Images.experience)
                .plainListHeaderRow()

            ForEach(viewModel.items) { item in
                ExperienceRow(title: item.title) {
                    viewModel.select(item)
                }
            }
        }
        .listStyle(.plain)
        .sectionNavigationBar(title: viewModel.title)
    }

    // MARK: - Private Properties

    @State private var viewModel: ExperienceViewModel

}

// MARK: - Row

/// Tappable row with a disclosure chevron. The view model decides what the tap pushes.
private struct ExperienceRow: View {

    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.s) {
                Text(title)
                    .typography(.Interface.body)
                    .foregroundStyle(Colors.textPrimary.swiftUIColor)

                Spacer(minLength: 0)

                Image(systemName: "chevron.right")
                    .typography(.Interface.footnote)
                    .foregroundStyle(Colors.textSecondary.swiftUIColor)
            }
            .padding(.vertical, Spacing.xs)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
    }

}

#Preview {
    NavigationStack {
        RootRouter(service: ServiceBuilder.makeAPIService()).experienceRouter.rootView(
            experience: Experience(
                title: "Experience",
                positions: [
                    .init(name: "MAUDAU · Senior iOS Developer", period: "Feb 2026 – Sep 2026", link: "", description: ""),
                    .init(name: "Loca · Senior iOS Developer", period: "Feb 2024 – Feb 2026", link: "", description: ""),
                ]
            )
        )
    }
    .tint(Colors.textPrimary.swiftUIColor)
}
