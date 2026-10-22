//
//  RootView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Hosts the app inside a single navigation stack driven by `RootRouter`.
/// The start screen is the root. Every other screen is a route pushed by a router in the graph.
public struct RootView: View {

    public init() {}

    public var body: some View {
        NavigationStack(path: $router.path) {
            router.rootView()
                .navigationDestinations(of: router)
        }
        // Light bar items: the system back button on pushed screens.
        .tint(Colors.textPrimary.swiftUIColor)
    }

    // MARK: - Private Properties

    @State private var router = RootRouter()
}

#Preview {
    RootView()
}
