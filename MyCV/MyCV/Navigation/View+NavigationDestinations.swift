//
//  View+NavigationDestinations.swift
//  MyCV
//

import SwiftUI

extension View {

    /// Registers the screens that `router` can push. Apply this modifier inside the navigation stack.
    func navigationDestinations<R: Router>(of router: R) -> some View {
        navigationDestination(for: R.Route.self) { route in
            router.destination(for: route)
        }
    }
}
