//
//  ExperienceDetailsView.swift
//  MyCV
//

import CoreUI
import SwiftUI

struct ExperienceDetailsView: View {

    init(viewModel: ExperienceDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.l) {
            // Descriptions hold several paragraphs, so the details scroll above the fixed button.
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.l) {
                    DetailRow(title: "Period", value: viewModel.period)
                    DetailRow(title: "Description", value: viewModel.description)
                }
            }

            Button {
                viewModel.openProject { url in
                    openURL(url)
                }
            } label: {
                Text("Open Project")
                    .typography(.Interface.buttonLarge)
                    .foregroundStyle(Colors.textOnNeon.swiftUIColor)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(
                        LinearGradient(
                            colors: [Colors.neonCyan.swiftUIColor, Colors.brandBlue.swiftUIColor],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .rounded(.infinity)
                    .boxShadow(.glowCyan)
            }
        }
        .padding(.horizontal, Spacing.m)
        .padding(.top, Spacing.xl)
        .padding(.bottom, Spacing.m)
        .alert("Oops", isPresented: $viewModel.showsUnavailableAlert) {
            Button("Ok", role: .cancel) { }
        } message: {
            Text("Sorry, this project has no public link.")
        }
        // Restore the default accent inside the content so the alert buttons stay readable
        // (the enclosing navigation stack uses a white tint for its bar items).
        .tint(Colors.neonCyan.swiftUIColor)
        .sectionNavigationBar(title: viewModel.title)
    }

    // MARK: - Private Properties

    @Environment(\.openURL) private var openURL
    @State private var viewModel: ExperienceDetailsViewModel

}

// MARK: - Row

private struct DetailRow: View {

    let title: LocalizedStringResource
    let value: String

    var body: some View {
        HStack(alignment: .top, spacing: Spacing.m) {
            Text(title)
                .typography(.HUD.label)
                .foregroundStyle(Colors.textSecondary.swiftUIColor)
                .frame(width: 88, alignment: .leading)
            Text(value)
                .typography(.Interface.body)
        }
    }

}

#Preview {
    NavigationStack {
        ExperienceDetailsView(viewModel: ExperienceDetailsViewModel(item: ExperienceItem(
            id: 0,
            title: "Loca · Senior iOS Developer",
            period: "Feb 2024 – Feb 2026",
            link: "https://apps.apple.com/ua/app/loca-explore-earn/id1670420863",
            description: "Remote.\n\n• Sole iOS engineer: built the app from scratch and owned it in production for two years.\n• Moved the app from Redux/Combine/UIKit to MVVM-C/SwiftUI with async/await."
        )))
    }
    .tint(Colors.textPrimary.swiftUIColor)
}
