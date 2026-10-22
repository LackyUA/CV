//
//  StartStartedProfileBadgeView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows the round profile photo with a neon ring on a glowing horizon line.
///
/// The horizon line goes across the top edge of the panel.
struct StartStartedProfileBadgeView: View {

    let configuration: StartStartedProfileBadgeViewConfiguration

    // MARK: - View

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Colors.neonCyan.swiftUIColor)
                .frame(height: Constants.borderWidth)

            configuration.image
                .resizable()
                .scaledToFill()
                .frame(width: Constants.size, height: Constants.size)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .strokeBorder(Colors.neonMagenta.swiftUIColor, lineWidth: Constants.borderWidth)
                }
                .boxShadow(.glowMagenta, shape: RoundedRectangle(cornerRadius: CornerRadius.infinity.rawValue))
        }
    }

    // MARK: - Constants

    enum Constants {

        /// The diameter of the profile photo.
        static let size: CGFloat = 120

        /// The width of the neon ring and of the horizon line.
        static let borderWidth: CGFloat = size / 20
    }
}

#Preview {
    ZStack {
        Colors.bg200.swiftUIColor
            .ignoresSafeArea()

        StartStartedProfileBadgeView(configuration: .init(image: Image(decorative: Images.profileImageCyber)))
    }
}
