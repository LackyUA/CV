//
//  ContactsViewModelState.swift
//  MyCV
//

import CoreUI

/// The state of the contacts screen.
enum ContactsViewModelState: Equatable {

    /// The data of the loaded state.
    struct Loaded: Equatable {

        /// The configuration of the loaded view.
        let configuration: ContactsLoadedViewConfiguration
    }

    /// The view model has not initiated the screen yet. The screen shows only its background.
    case idle

    /// The screen shows the contact cards.
    case loaded(Loaded)
}

extension ContactsViewModelState: AnimationIdentityProvider {

    /// Never changes, because the screen has no animated state changes.
    var layoutAnimationIdentity: AnyHashable {
        true
    }
}
