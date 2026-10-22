//
//  StartInitialTitleView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows an orange HUD kicker above the chromatic display title.
struct StartInitialTitleView: View {

    let configuration: StartInitialTitleViewConfiguration

    // MARK: - View

    var body: some View {
        VStack(spacing: Spacing.xs) {
            Text(configuration.kicker)
                .typography(.HUD.label)
                .foregroundStyle(Colors.neonOrange.swiftUIColor)
                .textShadow(.glowOrange)

            Text(configuration.title)
                .typography(.Display.extraLarge)
                .foregroundStyle(Colors.textPrimary.swiftUIColor)
                .shadow(color: Colors.neonMagenta.swiftUIColor, radius: 0, x: 2)
                .shadow(color: Colors.neonCyan.swiftUIColor, radius: 0, x: -2)
        }
        .multilineTextAlignment(.center)
    }
}
