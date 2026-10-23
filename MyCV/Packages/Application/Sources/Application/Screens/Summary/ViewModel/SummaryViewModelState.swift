//
//  SummaryViewModelState.swift
//  MyCV
//

import CoreUI

/// The state of the summary screen.
enum SummaryViewModelState: Equatable {

    /// The data of the loaded state.
    struct Loaded: Equatable {

        /// The configuration of the loaded view.
        let configuration: SummaryLoadedViewConfiguration
    }

    /// The view model has not initiated the screen yet. The screen shows only its background.
    case idle

    /// The screen shows an entry card for the profile paragraph and for each highlight.
    case loaded(Loaded)
}

extension SummaryViewModelState: AnimationIdentityProvider {

    /// Never changes, because the screen has no animated state changes.
    var layoutAnimationIdentity: AnyHashable {
        true
    }
}
