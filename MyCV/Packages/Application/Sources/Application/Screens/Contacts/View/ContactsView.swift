//
//  ContactsView.swift
//  MyCV
//

import CoreUI
import Services
import SwiftUI

/// Shows the contacts screen for the current state of the view model.
///
/// In the loaded state, the screen shows a card for the contact details and a card for the profiles.
struct ContactsView: View {

    init(viewModel: ContactsViewModel) {
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
                ContactsLoadedView(configuration: currentState.configuration)
            }
        }
        .onAppear {
            viewModel.initiate()
        }
    }

    // MARK: - Private Properties

    @State
    private var viewModel: ContactsViewModel
}

#Preview {
    NavigationStack {
        ContactsView(
            viewModel: ContactsViewModel(
                contacts: Contacts(
                    title: "Contacts",
                    description: "Ways to reach me.",
                    address: "Ivano-Frankivsk, Ukraine",
                    email: "name@example.com",
                    mobile: "+380000000000",
                    git: "https://github.com/LackyUA",
                    linkedin: "https://www.linkedin.com/in/d-dobrovolskyi/"
                )
            )
        )
    }
    .tint(Colors.textPrimary.swiftUIColor)
}
