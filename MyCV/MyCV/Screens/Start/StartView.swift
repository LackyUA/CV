//
//  StartView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Landing screen: shows the welcome circle, then animates into the sections menu.
struct StartView: View {

    @State private var isExpanding = false
    @State private var showsMenu = false
    @State private var selectedSection: CVSection?

    var body: some View {
        ZStack {
            (showsMenu ? Colors.accent.swiftUIColor : Color.white)
                .ignoresSafeArea()

            if showsMenu {
                SectionsMenuView { section in
                    selectedSection = section
                }
            } else {
                WelcomeView(isExpanding: isExpanding, onStart: start)
            }
        }
        .sheet(item: $selectedSection) { section in
            SectionSheet {
                SectionDestination(section: section)
            }
        }
    }

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
                    .typography(.Display.decorative)
                    .foregroundStyle(Colors.welcomeOrange.swiftUIColor)
                    .multilineTextAlignment(.center)
                    .offset(y: isExpanding ? -geometry.size.height : -220)

                ZStack {
                    Circle()
                        .fill(Colors.accent.swiftUIColor)

                    Text("Start")
                        .typography(.Display.large)
                        .foregroundStyle(.white)
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

// MARK: - Section routing

private struct SectionDestination: View {

    let section: CVSection

    var body: some View {
        switch section {
        case .contacts: ContactsView()
        case .summary: SummaryView()
        case .skills: SkillsView()
        case .education: EducationView()
        case .experience: ExperienceView()
        case .additional: AdditionalView()
        }
    }

}

#Preview {
    StartView()
}
