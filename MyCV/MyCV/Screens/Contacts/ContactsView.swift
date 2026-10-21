//
//  ContactsView.swift
//  MyCV
//

import SwiftUI

struct ContactsView: View {

    @State private var viewModel = ContactsViewModel()

    var body: some View {
        List {
            ScreenHeaderImage(name: "Contact")
                .plainListHeaderRow()

            ForEach(viewModel.rows) { row in
                ContactRow(
                    title: row.title,
                    details: row.details,
                    iconName: row.iconName,
                    action: row.action
                )
            }
        }
        .listStyle(.plain)
        .sectionNavigationBar(title: viewModel.title)
        .task {
            await viewModel.load()
        }
    }

}

// MARK: - Row

private struct ContactRow: View {

    let title: LocalizedStringResource
    let details: String
    let iconName: String?
    let action: ContactsViewModel.Row.Action?

    @Environment(\.openURL) private var openURL

    var body: some View {
        Button {
            perform()
        } label: {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Text(details)
                        .font(.body)
                        .foregroundStyle(.primary)
                }

                Spacer(minLength: 0)

                if let iconName {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                }
            }
            .padding(.vertical, 6)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .disabled(action == nil)
    }

    private func perform() {
        switch action {
        case .call(let number):
            if let url = URL(string: "tel://\(number)") {
                openURL(url)
            }
        case .open(let url):
            openURL(url)
        case nil:
            break
        }
    }

}

#Preview {
    SectionSheet {
        ContactsView()
    }
}
