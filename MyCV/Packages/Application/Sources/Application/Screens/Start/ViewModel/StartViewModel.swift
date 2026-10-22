//
//  StartViewModel.swift
//  MyCV
//

import CoreUI
import Observation
import Services
import SwiftUI

/// Keeps the state of the start screen and handles its actions.
///
/// The screen starts in the idle state. `initiate()` changes it to the initial state.
/// `load()` loads the CV sections while the user sees the initial state.
/// When the user taps the start orb, the view model marks the orb as starting.
/// When the screen view completes the animation of the orb, `finishStart()` records the completion.
/// The view model changes to the started state when the animation is complete and the sections are loaded.
/// If the sections do not load, the view model changes to the failed state.
/// The view model does not animate. The screen view animates the changes of the state.
@MainActor
@Observable
final class StartViewModel {

    init(service: any APIService, router: any Router<RootRouter.Route>) {
        self.service = service
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

    /// Loads the CV sections.
    ///
    /// The method has an effect only when the sections are not loaded and no load is in progress.
    /// Thus, the screen does not load the sections again when it appears again.
    func load() async {
        guard loadResult == nil, !isLoading else {
            return
        }
        isLoading = true
        defer { isLoading = false }

        do {
            loadResult = .success(try await service.fetchContent().sections)
        } catch {
            // A cancelled load is not a failure. The next appearance of the screen loads again.
            guard !Task.isCancelled else {
                return
            }
            loadResult = .failure(error)
        }
        showLoadResultIfReady()
    }

    /// Starts to expand the start orb.
    func start() {
        guard case .initial(let currentState) = state, !currentState.configuration.isStarting else {
            return
        }
        state = .initial(.init(configuration: initialConfiguration(isStarting: true)))
    }

    /// Records that the start orb has expanded. Shows the sections menu if the sections are loaded.
    func finishStart() {
        guard case .initial(let currentState) = state, currentState.configuration.isStarting else {
            return
        }
        isStartFinished = true
        showLoadResultIfReady()
    }

    /// Loads the CV sections again after a failure.
    func retry() {
        guard case .failed = state, !isLoading else {
            return
        }
        loadResult = nil
        Task {
            await load()
        }
    }

    /// Pushes the selected section onto the stack.
    func select(_ section: ContentSection) {
        router.push(.section(section))
    }

    // MARK: - Private Properties

    private let service: any APIService
    private let router: any Router<RootRouter.Route>

    /// The result of the last load, or `nil` when no load has completed.
    private var loadResult: Result<[ContentSection], any Error>?

    /// A Boolean value that indicates whether a load is in progress.
    private var isLoading = false

    /// A Boolean value that indicates whether the animation of the start orb is complete.
    private var isStartFinished = false

    // MARK: - Private Methods

    /// Shows the result of the load when the start orb has expanded and the load is complete.
    private func showLoadResultIfReady() {
        guard isStartFinished, let loadResult else {
            return
        }
        switch loadResult {
        case .success(let sections):
            state = .started(.init(configuration: startedConfiguration(sections: sections)))
        case .failure:
            state = .failed(.init(configuration: failedConfiguration()))
        }
    }

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

    private func startedConfiguration(sections: [ContentSection]) -> StartStartedViewConfiguration {
        .init(
            profileBadge: .init(
                image: Image(decorative: Images.profileImageCyber),
                glitchImage: Image(decorative: Images.profileImage)
            ),
            panel: .init(
                name: .init(firstName: "Dmytro", lastName: "Dobrovolskyi"),
                sections: .init(
                    sections: sections.enumerated().map { index, section in
                        .init(
                            id: .init(rawValue: index),
                            title: section.title,
                            description: section.description,
                            // The loaded sections do not change, so the action can keep its section.
                            select: { [weak self] in
                                self?.select(section)
                            }
                        )
                    }
                )
            )
        )
    }

    private func failedConfiguration() -> StartFailedViewConfiguration {
        .init(
            message: "The CV could not load.",
            retryButtonTitle: "Try again",
            retry: { [weak self] in
                self?.retry()
            }
        )
    }
}
