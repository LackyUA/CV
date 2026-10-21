//
//  ExperienceDetailsView.swift
//  MyCV
//

import SwiftUI

struct ExperienceDetailsView: View {

    let item: ExperienceItem

    @Environment(\.openURL) private var openURL
    @State private var showsUnavailableAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            DetailRow(title: "Period", value: item.period)
            DetailRow(title: "Description", value: item.description)

            Spacer()

            Button {
                openProject()
            } label: {
                Text("Open Git Project")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color(.accent), in: .rect(cornerRadius: 8))
            }
        }
        .padding(.horizontal, 15)
        .padding(.top, 40)
        .padding(.bottom, 15)
        .alert("Oops", isPresented: $showsUnavailableAlert) {
            Button("Ok", role: .cancel) { }
        } message: {
            Text("Sorry, I can't distribute this code.")
        }
        // Restore the default accent inside the content so the alert buttons stay readable
        // (the enclosing navigation stack uses a white tint for its bar items).
        .tint(Color(.accent))
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
        HStack(alignment: .top, spacing: 15) {
            Text(title)
                .frame(width: 88, alignment: .leading)
            Text(value)
        }
        .font(.body)
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
    .tint(.white)
}
