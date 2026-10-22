//
//  View+SectionNavigationBar.swift
//  MyCV
//

import CoreUI
import SwiftUI

extension View {

    /// Applies the shared screen appearance: night background, night bar, light inline title and status bar.
    ///
    /// - Parameters:
    ///   - title: The inline title of the bar.
    ///   - barBackground: The visibility of the night bar background. Use `.hidden` to show the screen content
    ///     under the bar. The default value is `.visible`.
    func sectionNavigationBar(title: String, barBackground: Visibility = .visible) -> some View {
        self
            .navigationTitle(title)
            .toolbarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(Colors.bg100.swiftUIColor.ignoresSafeArea())
            .toolbarBackground(Colors.bg100.swiftUIColor, for: .navigationBar)
            .toolbarBackgroundVisibility(barBackground, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
    }

}
