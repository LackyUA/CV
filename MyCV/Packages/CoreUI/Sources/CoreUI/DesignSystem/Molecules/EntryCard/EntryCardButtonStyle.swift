//
//  EntryCardButtonStyle.swift
//  CoreUI
//

import SwiftUI

/// A button style that makes an ``EntryCard`` in the label selectable.
///
/// The card shows a cyan disclosure chevron. On iOS 26 and later, the native glass reacts to a press.
/// On earlier versions, the glass gets a cyan tint and the card scales down while the user presses it.
/// To show the selected state, apply ``SwiftUICore/View/entryCardSelected(_:)``.
/// A selected card has a cyan tint, a cyan rim and a cyan glow.
///
/// ```swift
/// Button(action: openSkills) {
///     EntryCard(configuration: .init(title: "Skills"))
/// }
/// .buttonStyle(.entryCard)
/// .entryCardSelected(isSkillsSelected)
/// ```
public struct EntryCardButtonStyle: ButtonStyle {

    // MARK: - ButtonStyle

    public func makeBody(configuration: Configuration) -> some View {
        ContentView(configuration: configuration, style: self)
    }

    // MARK: - Resolved Styles

    init(`default`: EntryCardAppearance, pressed: EntryCardAppearance, selected: EntryCardAppearance) {
        self.default = `default`
        self.pressed = pressed
        self.selected = selected
    }

    /// The appearance of the card in each interaction state.
    let `default`, pressed, selected: EntryCardAppearance
}

private struct ContentView: View {

    let configuration: ButtonStyleConfiguration, style: EntryCardButtonStyle

    // MARK: - View

    var body: some View {
        configuration.label
            .environment(\.entryCardAppearance, appearance)
            .pressScale(isPressed: configuration.isPressed)
            .accessibilityAddTraits(isSelected ? .isSelected : [])
            .sensoryFeedback(.selection, trigger: isSelected) { _, isSelected in
                isSelected
            }
    }

    // MARK: - Private Properties

    @Environment(\.entryCardSelected)
    private var isSelected

    private var appearance: EntryCardAppearance {
        if isSelected {
            return style.selected
        }
        guard configuration.isPressed else {
            return style.default
        }
        if #available(iOS 26, *) {
            // The native interactive glass reacts to the press, so the card keeps its default appearance.
            return style.default
        }
        return style.pressed
    }

    // MARK: - Constants

    fileprivate enum Constants {

        /// The scale of the pressed card.
        static let pressedScale: CGFloat = 0.97
    }
}

extension View {

    /// Scales the card down while the user presses it.
    ///
    /// On iOS 26 and later, the native interactive glass of the card reacts to the press.
    /// Thus, the method does not change the view on these versions.
    @ViewBuilder
    fileprivate func pressScale(isPressed: Bool) -> some View {
        if #available(iOS 26, *) {
            self
        } else {
            scaleEffect(isPressed ? ContentView.Constants.pressedScale : 1)
                .animation(.press, value: isPressed)
        }
    }
}
