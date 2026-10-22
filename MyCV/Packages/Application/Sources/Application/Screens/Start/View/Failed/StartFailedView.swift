//
//  StartFailedView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows a message that the CV did not load and a glass button that loads it again.
struct StartFailedView: View {

    let configuration: StartFailedViewConfiguration

    // MARK: - View

    var body: some View {
        VStack(spacing: Spacing.m) {
            Text(configuration.message)
                .typography(.Interface.body)
                .foregroundStyle(Colors.textSecondary.swiftUIColor)
                .multilineTextAlignment(.center)

            Button {
                configuration.retry()
            } label: {
                Text(configuration.retryButtonTitle)
                    .typography(.Interface.buttonLarge)
                    .foregroundStyle(Colors.textPrimary.swiftUIColor)
                    .frame(maxWidth: .infinity, minHeight: Constants.buttonHeight)
                    .rounded(.infinity)
                    .backgroundBlur(.regular, tint: Colors.glassFill.swiftUIColor)
                    .border(color: Colors.glassStroke.swiftUIColor, lineWidth: .m)
                    .boxShadow(.glass)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, Spacing.m)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Constants

    private enum Constants {

        /// The minimum height of the retry button.
        static let buttonHeight: CGFloat = 56
    }
}

#Preview {
    ZStack {
        Colors.bg100.swiftUIColor
            .ignoresSafeArea()

        StartFailedView(
            configuration: .init(
                message: "The CV could not load.",
                retryButtonTitle: "Try again",
                retry: {}
            )
        )
    }
}
