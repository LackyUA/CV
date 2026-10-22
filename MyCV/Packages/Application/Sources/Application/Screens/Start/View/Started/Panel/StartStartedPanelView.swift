//
//  StartStartedPanelView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows the owner's name above the section cards.
struct StartStartedPanelView: View {

    let configuration: StartStartedPanelViewConfiguration

    // MARK: - View

    var body: some View {
        VStack(spacing: Spacing.s) {
            // Keeps the space under the profile badge free.
            Color.clear
                .frame(height: Constants.rowHeight)

            StartStartedNameView(configuration: configuration.name)
                .frame(height: Constants.rowHeight)

            StartStartedSectionsView(configuration: configuration.sections)
        }
    }

    // MARK: - Constants

    private enum Constants {

        /// The height of the badge space and of the name.
        static let rowHeight: CGFloat = 70
    }
}
