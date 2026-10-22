//
//  StartInitialView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows the welcome title above the start orb.
struct StartInitialView: View {

    let configuration: StartInitialViewConfiguration

    // MARK: - View

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                StartInitialTitleView(configuration: configuration.title)
                    .offset(y: configuration.isStarting ? -geometry.size.height : Constants.titleOffset)

                Button {
                    configuration.start()
                } label: {
                    Text(configuration.startButtonTitle)
                }
                .buttonStyle(.orb)
                .orbButtonExpanded(configuration.isStarting)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    // MARK: - Constants

    private enum Constants {

        /// The vertical offset of the title from the center of the screen.
        static let titleOffset: CGFloat = -220
    }
}

#Preview {
    ZStack {
        Colors.bg100.swiftUIColor
            .ignoresSafeArea()

        StartInitialView(
            configuration: .init(
                title: .init(kicker: "Welcome to", title: "My CV"),
                startButtonTitle: "Start",
                isStarting: false,
                start: {}
            )
        )
    }
}
