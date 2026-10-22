//
//  StartStartedProfileBadgeView.swift
//  MyCV
//

import CoreUI
import SwiftUI

/// Shows the round profile photo with a neon ring on a glowing horizon line.
///
/// The horizon line goes across the top edge of the panel.
/// The badge glitches at a random interval. During a glitch, it flashes the glitch photo
/// several times and then shows the main photo again. The glitch stops when Reduce Motion is on.
struct StartStartedProfileBadgeView: View {

    let configuration: StartStartedProfileBadgeViewConfiguration

    // MARK: - View

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Colors.neonCyan.swiftUIColor)
                .frame(height: Constants.borderWidth)
                .boxShadow(.glowCyan, shape: .rect)

            currentImage
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
        .task(id: reduceMotion) {
            guard !reduceMotion else {
                showsGlitchImage = false
                return
            }
            try? await runGlitchLoop()
        }
    }

    // MARK: - Constants

    enum Constants {

        /// The diameter of the profile photo.
        static let size: CGFloat = 120

        /// The width of the neon ring and of the horizon line.
        static let borderWidth: CGFloat = size / 40

        /// The range of the pause between two glitches, in seconds.
        static let glitchPause: ClosedRange<TimeInterval> = 3...4

        /// The range of the number of photo swaps in one glitch.
        static let glitchSwapCount: ClosedRange<Int> = 4...5

        /// The range of the time that each photo stays visible during a glitch, in seconds.
        static let glitchSwapDuration: ClosedRange<TimeInterval> = 0.05...0.1
    }

    // MARK: - Private Properties

    @Environment(\.accessibilityReduceMotion)
    private var reduceMotion

    @State
    private var showsGlitchImage = false

    private var currentImage: Image {
        showsGlitchImage ? configuration.glitchImage : configuration.image
    }

    // MARK: - Private Methods

    /// Repeats the glitch until the task is cancelled.
    ///
    /// Each cycle waits a random pause, swaps the photo a random number of times,
    /// and then shows the main photo. The swaps do not animate, so the photo changes instantly.
    private func runGlitchLoop() async throws {
        showsGlitchImage = false
        while true {
            try await Task.sleep(for: .seconds(.random(in: Constants.glitchPause)))
            for _ in 0..<Int.random(in: Constants.glitchSwapCount) {
                showsGlitchImage.toggle()
                try await Task.sleep(for: .seconds(.random(in: Constants.glitchSwapDuration)))
            }
            showsGlitchImage = false
        }
    }
}

#Preview {
    ZStack {
        Colors.bg200.swiftUIColor
            .ignoresSafeArea()

        StartStartedProfileBadgeView(
            configuration: .init(
                image: Image(decorative: Images.profileImageCyber),
                glitchImage: Image(decorative: Images.profileImage)
            )
        )
    }
}
