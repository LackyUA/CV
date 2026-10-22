//
//  StartStartedView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows the night panel with the owner's name and the section buttons.
///
/// The panel slides up from the bottom. The profile badge scales in on the top edge of the panel.
struct StartStartedView: View {

    let configuration: StartStartedViewConfiguration

    // MARK: - View

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Color.clear
                    .frame(height: geometry.size.height / Constants.panelTopFraction)

                StartStartedPanelView(configuration: configuration.panel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Colors.bg200.swiftUIColor.ignoresSafeArea(edges: .bottom))
                    .overlay(alignment: .top) {
                        StartStartedProfileBadgeView(configuration: configuration.profileBadge)
                            .scaleEffect(isPresented ? 1 : Constants.hiddenBadgeScale)
                            .offset(y: -StartStartedProfileBadgeView.Constants.size / 2)
                    }
            }
            .offset(y: isPresented ? 0 : geometry.size.height)
        }
        .onAppear {
            withAnimation(.spring(duration: Constants.presentationDuration, bounce: Constants.presentationBounce)) {
                isPresented = true
            }
        }
    }

    // MARK: - Private Properties

    @State
    private var isPresented = false

    // MARK: - Constants

    private enum Constants {

        /// The top of the panel as a fraction of the screen height. The panel starts at 1/6 of the height.
        static let panelTopFraction: CGFloat = 6

        /// The scale of the profile badge before the panel appears.
        static let hiddenBadgeScale: CGFloat = 0.01

        /// The duration of the spring that presents the panel.
        static let presentationDuration: TimeInterval = 0.7

        /// The bounce of the spring that presents the panel.
        static let presentationBounce: Double = 0.05
    }
}

#Preview {
    ZStack {
        Colors.bg100.swiftUIColor
            .ignoresSafeArea()

        StartStartedView(
            configuration: .init(
                profileBadge: .init(image: Image(decorative: Images.profileImageCyber)),
                panel: .init(
                    name: .init(firstName: "Dmytro", lastName: "Dobrovolskyy"),
                    sections: .init(
                        sections: [
                            .init(id: .init(rawValue: .contacts), title: "Contacts", select: {}),
                            .init(id: .init(rawValue: .summary), title: "Objective & summary", select: {}),
                            .init(id: .init(rawValue: .skills), title: "Skills", select: {}),
                        ]
                    )
                )
            )
        )
    }
}
