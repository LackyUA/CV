//
//  StartViewModel.swift
//  MyCV
//

import CoreUI
import Observation
import SwiftUI

/// Keeps the state of the start screen and handles its actions.
///
/// The screen starts in the idle state. `initiate()` changes it to the initial state.
/// When the user taps the start orb, the view model marks the orb as starting.
/// When the screen view completes the animation of the orb, `finishStart()` changes to the started state.
/// The view model does not animate. The screen view animates the changes of the state.
@MainActor
@Observable
final class StartViewModel {

    init(router: any Router<RootRouter.Route>) {
        self.router = router
        state = .idle
    }

    /// The current state of the screen.
    private(set) var state: StartViewModelState

    /// Shows the welcome title and the start orb.
    ///
    /// The method has an effect only in the idle state. Thus, the screen keeps its state when it appears again.
    func initiate() {
        guard case .idle = state else {
            return
        }
        state = .initial(.init(configuration: initialConfiguration(isStarting: false)))
    }

    /// Starts to expand the start orb.
    func start() {
        guard case .initial(let currentState) = state, !currentState.configuration.isStarting else {
            return
        }
        state = .initial(.init(configuration: initialConfiguration(isStarting: true)))
    }

    /// Shows the sections menu after the start orb expands.
    func finishStart() {
        guard case .initial(let currentState) = state, currentState.configuration.isStarting else {
            return
        }
        state = .started(.init(configuration: startedConfiguration()))
    }

    /// Pushes the selected section onto the stack.
    func select(_ section: CVSection) {
        router.push(.section(section))
    }

    // MARK: - Private Properties

    private let router: any Router<RootRouter.Route>

    // MARK: - Private Methods

    private func initialConfiguration(isStarting: Bool) -> StartInitialViewConfiguration {
        .init(
            title: .init(kicker: "Welcome to", title: "My CV"),
            startButtonTitle: "Start",
            isStarting: isStarting,
            start: { [weak self] in
                self?.start()
            }
        )
    }

    private func startedConfiguration() -> StartStartedViewConfiguration {
        .init(
            profileBadge: .init(image: Image(decorative: Images.profileImageCyber)),
            panel: .init(
                name: .init(firstName: "Dmytro", lastName: "Dobrovolskyi"),
                sections: .init(
                    sections: CVSection.allCases.map { section in
                        .init(
                            id: .init(rawValue: section),
                            title: section.title,
                            select: { [weak self] in
                                self?.select(section)
                            }
                        )
                    }
                )
            )
        )
    }
}
