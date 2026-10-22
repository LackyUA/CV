//
//  Router.swift
//  MyCV
//

import SwiftUI

/// Pushes routes of one type onto the shared navigation stack and builds the screen for each route.
///
/// The root router owns the `NavigationPath`. A child router forwards `path` to its parent.
/// Thus, every router in the graph pushes onto the same `NavigationStack`.
@MainActor
protocol Router<Route>: AnyObject {

    /// A screen that this router can push.
    associatedtype Route: Hashable

    /// The view that this router builds for a route.
    associatedtype Destination: View

    /// The shared navigation path. It holds the pushed routes of every router, in order from the root.
    var path: NavigationPath { get set }

    /// Pushes a screen onto the stack.
    func push(_ route: Route)

    /// Pops the top screen. Does nothing when the stack shows the root.
    func pop()

    /// Pops every pushed screen and returns to the root.
    func popToRoot()

    /// Builds the screen for a pushed route.
    @ViewBuilder
    func destination(for route: Route) -> Destination
}

extension Router {

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
