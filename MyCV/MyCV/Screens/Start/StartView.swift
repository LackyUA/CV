//
//  StartView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Landing screen: shows the welcome circle, then animates into the sections menu.
/// A section button hands the selected section to the view model, which pushes it.
struct StartView: View {

    init(viewModel: StartViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Colors.bg100.swiftUIColor
                .ignoresSafeArea()

            if showsMenu {
                SectionsMenuView { section in
                    viewModel.select(section)
                }
            } else {
                WelcomeView(isExpanding: isExpanding, onStart: start)
            }
        }
        // The landing screen has no bar, so pushed screens get a plain "Back" button.
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Private Properties

    @State private var viewModel: StartViewModel
    @State private var isExpanding = false
    @State private var showsMenu = false

    // MARK: - Private Methods

    /// First animation step: fade the "Start" label, grow the circle and push the title off screen.
    /// When it completes the menu replaces the welcome content and plays its own entrance animation.
    private func start() {
        guard !isExpanding else { return }

        withAnimation(.easeInOut(duration: 0.5)) {
            isExpanding = true
        } completion: {
            showsMenu = true
        }
    }

}

// MARK: - Welcome content

private struct WelcomeView: View {

    let isExpanding: Bool
    let onStart: () -> Void

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text("Welcome To\nMy CV")
                    .typography(.Display.extraLarge)
                    .foregroundStyle(Colors.textPrimary.swiftUIColor)
                    // Chromatic split shadow of `display-xl`.
                    .shadow(color: Colors.neonMagenta.swiftUIColor, radius: 0, x: 2)
                    .shadow(color: Colors.neonCyan.swiftUIColor, radius: 0, x: -2)
                    .multilineTextAlignment(.center)
                    .offset(y: isExpanding ? -geometry.size.height : -220)

                ZStack {
                    Color.clear
                        .rounded(.infinity)
                        .backgroundBlur(.regular, tint: Colors.glassFill.swiftUIColor)
                        .border(color: Colors.glassStroke.swiftUIColor, lineWidth: .m)
                        .boxShadow(.glowCyan)

                    Text("Start")
                        .typography(.Display.orb)
                        .foregroundStyle(Colors.neonCyan.swiftUIColor)
                        .opacity(isExpanding ? 0 : 1)
                }
                .frame(width: 240, height: 240)
                .scaleEffect(isExpanding ? 4 : 1)
                .onTapGesture {
                    onStart()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

}

#Preview {
    StartView(viewModel: StartViewModel(router: RootRouter()))
}
