//
//  MyCVApp.swift
//  MyCV
//

import SwiftUI

/// SwiftUI entry point replacing the storyboard-based `AppDelegate` launch.
@main
struct MyCVApp: App {

    var body: some Scene {
        WindowGroup {
            StartView()
                // The design system has a single Night theme.
                .preferredColorScheme(.dark)
        }
    }

}
