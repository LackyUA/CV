//
//  StartViewModel.swift
//  MyCV
//

import Foundation
import Observation

/// Handles the actions of the start screen. The welcome animation state stays in the view.
@MainActor
@Observable
final class StartViewModel {

    init(router: any Router<RootRouter.Route>) {
        self.router = router
    }

    /// Pushes the selected section onto the stack.
    func select(_ section: CVSection) {
        router.push(.section(section))
    }

    // MARK: - Private Properties

    private let router: any Router<RootRouter.Route>

}
