//
//  StartStartedNameView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows the first name of the owner above the last name.
struct StartStartedNameView: View {

    let configuration: StartStartedNameViewConfiguration

    // MARK: - View

    var body: some View {
        VStack(spacing: 0) {
            Text(configuration.firstName)
                .typography(.Display.name)
                .frame(maxHeight: .infinity)
            Text(configuration.lastName)
                .typography(.Display.name)
                .frame(maxHeight: .infinity)
        }
        .foregroundStyle(Colors.textPrimary.swiftUIColor)
    }
}
