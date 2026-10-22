//
//  StartViewModelState.swift
//  MyCV
//

import CoreUI

/// The state of the start screen.
enum StartViewModelState: Equatable {

    /// The data of the initial state.
    struct Initial: Equatable {

        /// The configuration of the initial view.
        let configuration: StartInitialViewConfiguration
    }

    /// The data of the started state.
    struct Started: Equatable {

        /// The configuration of the started view.
        let configuration: StartStartedViewConfiguration
    }

    /// The data of the failed state.
    struct Failed: Equatable {

        /// The configuration of the failed view.
        let configuration: StartFailedViewConfiguration
    }

    /// The view model has not initiated the screen yet. The screen shows only its background.
    case idle

    /// The screen shows the welcome title and the start orb.
    case initial(Initial)

    /// The screen shows the owner's name and the section cards.
    case started(Started)

    /// The sections did not load. The screen shows a message and a button that loads the sections again.
    case failed(Failed)
}

extension StartViewModelState: AnimationIdentityProvider {

    /// Changes only when the start orb starts to expand.
    ///
    /// The screen view animates a change of this identity.
    /// The changes from idle to initial and from initial to started or failed do not change it.
    /// Thus, the screen view does not animate these changes.
    var layoutAnimationIdentity: AnyHashable {
        switch self {
        case .idle:
            false
        case .initial(let currentState):
            currentState.configuration.isStarting
        case .started, .failed:
            true
        }
    }
}
