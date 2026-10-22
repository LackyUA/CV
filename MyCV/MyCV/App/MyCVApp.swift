//
//  MyCVApp.swift
//  MyCV
//

import SwiftUI

/// SwiftUI entry point replacing the storyboard-based `AppDelegate` launch.
@main
struct MyCVApp: App {

    init() {
        AppDependencies.register()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                // The design system has a single Night theme.
                .preferredColorScheme(.dark)
        }
    }

}
