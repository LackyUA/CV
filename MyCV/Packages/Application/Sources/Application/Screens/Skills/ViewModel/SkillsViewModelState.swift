//
//  SkillsViewModelState.swift
//  MyCV
//

import CoreUI

/// The state of the skills screen.
enum SkillsViewModelState: Equatable {

    /// The data of the loaded state.
    struct Loaded: Equatable {

        /// The configuration of the loaded view.
        let configuration: SkillsLoadedViewConfiguration
    }

    /// The view model has not initiated the screen yet. The screen shows only its background.
    case idle

    /// The screen shows an entry card for each group of skills.
    case loaded(Loaded)
}

extension SkillsViewModelState: AnimationIdentityProvider {

    /// Never changes, because the screen has no animated state changes.
    var layoutAnimationIdentity: AnyHashable {
        true
    }
}
