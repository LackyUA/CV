//
//  SectionSheet.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Hosts a CV section inside its own navigation stack when presented from the start screen.
/// Provides the "Back" button that dismisses the sheet, mirroring the previous UIKit flow.
struct SectionSheet<Content: View>: View {

    @Environment(\.dismiss) private var dismiss
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        NavigationStack {
            content
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Back") {
                            dismiss()
                        }
                    }
                }
        }
        // Light bar items (custom "Back" and the system back button on pushed screens).
        .tint(Colors.textPrimary.swiftUIColor)
    }

}

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
