//
//  StartStartedPanelView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows the owner's name above the section buttons.
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
                .padding(.horizontal, Spacing.m)
                .padding(.bottom, Spacing.s)
        }
    }

    // MARK: - Constants

    private enum Constants {

        /// The height of the badge space and of the name.
        static let rowHeight: CGFloat = 70
    }
}
