//
//  RouterSpy.swift
//  MyCVTests
//

import SwiftUI
@testable import Application

/// Records the routes that a view model pushes. Builds no screens.
@MainActor
final class RouterSpy<Route: Hashable>: Router {

    var path = NavigationPath()

    private(set) var pushedRoutes: [Route] = []

    func push(_ route: Route) {
        pushedRoutes.append(route)
    }

    func destination(for route: Route) -> some View {
        EmptyView()
    }

}
