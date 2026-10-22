//
//  ContactsView.swift
//  MyCV
//

import CoreUI
import Services
import SwiftUI

struct ContactsView: View {

    init(viewModel: ContactsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ScreenHeaderImage(asset: Images.contact)
                .plainListHeaderRow()

            ForEach(viewModel.rows) { row in
                ContactRow(
                    title: row.title,
                    details: row.details,
                    icon: row.icon,
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

    // MARK: - Private Properties

    @State private var viewModel: ContactsViewModel

}

// MARK: - Row

private struct ContactRow: View {

    let title: LocalizedStringResource
    let details: String
    let icon: ContactsViewModel.Row.Icon?
    let action: ContactsViewModel.Row.Action?

    @Environment(\.openURL) private var openURL

    var body: some View {
        Button {
            perform()
        } label: {
            HStack(spacing: Spacing.s) {
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(title)
                        .typography(.HUD.label)
                        .foregroundStyle(Colors.textSecondary.swiftUIColor)
                    Text(details)
                        .typography(.Interface.body)
                        .foregroundStyle(Colors.textPrimary.swiftUIColor)
                }

                Spacer(minLength: 0)

                if let icon {
                    iconAsset(for: icon).swiftUIImage
                        .scaled(idealWidth: .Icon.large, idealHeight: .Icon.large, relativeTo: .body)
                }
            }
            .padding(.vertical, Spacing.xs)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .disabled(action == nil)
    }

    private func iconAsset(for icon: ContactsViewModel.Row.Icon) -> ImageAsset {
        switch icon {
        case .call: Images.call
        case .web: Images.web
        }
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
    NavigationStack {
        ContactsView(viewModel: ContactsViewModel(service: ServiceBuilder.makeAPIService()))
    }
    .tint(Colors.textPrimary.swiftUIColor)
}
