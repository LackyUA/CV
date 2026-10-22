//
//  StartOrbButtonStyle.swift
//  CoreUI
//

import SwiftUI

/// A button style that shows the button as a round Liquid Glass orb.
///
/// The orb glows cyan and shows the label in uppercase Orbitron.
/// When the user presses the orb, the glass gets a cyan tint and the orb scales down.
/// To expand the orb and fade it out, apply ``SwiftUICore/View/startOrbButtonExpanded(_:)``.
///
/// ```swift
/// Button("Start", action: start)
///     .buttonStyle(.startOrb)
///     .startOrbButtonExpanded(isExpanding)
/// ```
public struct StartOrbButtonStyle: ButtonStyle {

    // MARK: - ButtonStyle

    public func makeBody(configuration: Configuration) -> some View {
        ContentView(configuration: configuration, style: self)
    }

    // MARK: - Resolved Styles

    /// The appearance of the orb in one interaction state.
    struct Resolved {

        /// The color of the label.
        let foregroundColor: Color

        /// The color that the orb layers over the glass fill.
        let tintColor: Color

        /// The halo around the orb.
        let glow: BoxShadow
    }

    init(`default`: Resolved, pressed: Resolved) {
        self.default = `default`
        self.pressed = pressed
    }

    /// The appearance of the orb in each interaction state.
    let `default`, pressed: Resolved
}

private struct ContentView: View {

    let configuration: ButtonStyleConfiguration, style: StartOrbButtonStyle

    // MARK: - View

    var body: some View {
        configuration.label
            .typography(.Display.orb)
            .foregroundStyle(resolvedStyle.foregroundColor)
            .frame(width: Constants.diameter, height: Constants.diameter)
            .background {
                ZStack {
                    Circle()
                        .fill(resolvedStyle.tintColor)

                    Circle()
                        .strokeBorder(Colors.glassStroke.swiftUIColor, lineWidth: BorderLineWidth.m.rawValue)
                        .padding(Spacing.m)
                }
            }
            .rounded(.infinity)
            .backgroundBlur(.regular, tint: Colors.glassFill.swiftUIColor)
            .border(color: Colors.glassStroke.swiftUIColor, lineWidth: .m)
            .boxShadow(resolvedStyle.glow)
            .contentShape(.circle)
            .scaleEffect(scale)
            .animation(.spring(response: 0.45, dampingFraction: 0.8), value: configuration.isPressed)
            .opacity(isExpanded ? 0 : 1)
            .allowsHitTesting(!isExpanded)
            .accessibilityHidden(isExpanded)
            .sensoryFeedback(.impact(flexibility: .soft), trigger: isExpanded) { _, isExpanded in
                isExpanded
            }
    }

    // MARK: - Private Properties

    @Environment(\.startOrbButtonExpanded)
    private var isExpanded

    private var resolvedStyle: StartOrbButtonStyle.Resolved {
        configuration.isPressed ? style.pressed : style.default
    }

    private var scale: CGFloat {
        if isExpanded {
            return Constants.expandedScale
        }
        return configuration.isPressed ? Constants.pressedScale : 1
    }

    // MARK: - Constants

    private enum Constants {

        /// 240 pt. The `dim-start-orb` dimension of the design system.
        static let diameter: CGFloat = 240

        /// The scale of the expanded orb.
        static let expandedScale: CGFloat = 4

        /// The scale of the pressed orb.
        static let pressedScale: CGFloat = 0.97
    }
}

#Preview {
    @Previewable @State var isExpanded = false

    ZStack {
        Colors.bg100.swiftUIColor
            .ignoresSafeArea()

        Button("Start") {
            withAnimation(.easeInOut(duration: 0.5)) {
                isExpanded = true
            }
        }
        .buttonStyle(.startOrb)
        .startOrbButtonExpanded(isExpanded)
    }
    .overlay(alignment: .bottom) {
        Button("Reset") {
            isExpanded = false
        }
        .padding(Spacing.l)
    }
}
