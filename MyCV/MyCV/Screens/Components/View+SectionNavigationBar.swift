//
//  View+SectionNavigationBar.swift
//  MyCV
//

import CoreUI
import SwiftUI

extension View {

    /// Applies the shared screen appearance: night background, night bar, light inline title and status bar.
    func sectionNavigationBar(title: String) -> some View {
        self
            .navigationTitle(title)
            .toolbarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(Colors.bg100.swiftUIColor.ignoresSafeArea())
            .toolbarBackground(Colors.bg100.swiftUIColor, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
    }

}
