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
            DetailRow(title: "Period", value: viewModel.period)
            DetailRow(title: "Description", value: viewModel.description)

            Spacer()

            Button {
                viewModel.openProject { url in
                    openURL(url)
                }
            } label: {
                Text("Open Git Project")
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
            Text("Sorry, I can't distribute this code.")
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
            title: "Road signs",
            period: "2 months",
            link: "https://github.com/LackyUA/Road-signs",
            description: "Developed a program for learning road signs."
        )))
    }
    .tint(Colors.textPrimary.swiftUIColor)
}
