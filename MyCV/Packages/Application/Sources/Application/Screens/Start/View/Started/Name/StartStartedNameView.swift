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
                .foregroundStyle(Colors.textPrimary.swiftUIColor)
                .shadow(color: Colors.neonMagenta.swiftUIColor, radius: 0, x: 2)
                .shadow(color: Colors.neonCyan.swiftUIColor, radius: 0, x: -2)
                .frame(maxHeight: .infinity)

            Text(configuration.lastName)
                .typography(.Display.name)
                .foregroundStyle(Colors.textPrimary.swiftUIColor)
                .shadow(color: Colors.neonMagenta.swiftUIColor, radius: 0, x: 2)
                .shadow(color: Colors.neonCyan.swiftUIColor, radius: 0, x: -2)
                .frame(maxHeight: .infinity)
        }
        .foregroundStyle(Colors.textPrimary.swiftUIColor)
    }
}
