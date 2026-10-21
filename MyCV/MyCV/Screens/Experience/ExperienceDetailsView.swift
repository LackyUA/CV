//
//  ExperienceDetailsView.swift
//  MyCV
//

import CoreUI
import SwiftUI

struct ExperienceDetailsView: View {

    let item: ExperienceItem

    @Environment(\.openURL) private var openURL
    @State private var showsUnavailableAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.l) {
            DetailRow(title: "Period", value: item.period)
            DetailRow(title: "Description", value: item.description)

            Spacer()

            Button {
                openProject()
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
        .alert("Oops", isPresented: $showsUnavailableAlert) {
            Button("Ok", role: .cancel) { }
        } message: {
            Text("Sorry, I can't distribute this code.")
        }
        // Restore the default accent inside the content so the alert buttons stay readable
        // (the enclosing navigation stack uses a white tint for its bar items).
        .tint(Colors.neonCyan.swiftUIColor)
        .sectionNavigationBar(title: item.title)
    }

    private func openProject() {
        guard !item.link.isEmpty, let url = URL(string: item.link) else {
            showsUnavailableAlert = true
            return
        }
        openURL(url)
    }

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
        ExperienceDetailsView(item: ExperienceItem(
            id: 0,
            title: "Road signs",
            period: "2 months",
            link: "https://github.com/LackyUA/Road-signs",
            description: "Developed a program for learning road signs."
        ))
    }
    .tint(Colors.textPrimary.swiftUIColor)
}
