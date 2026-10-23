//
//  EntryCard.swift
//  CoreUI
//

import SwiftUI

/// A Liquid Glass card that shows a title, a description, or both.
///
/// On iOS 26 and later, the card uses the native Liquid Glass effect. On earlier versions, it uses a backdrop blur.
///
/// Without a description, the card shows a larger title in a compact card, for example a menu item.
/// With a description, the card shows a headline over body text, for example a CV fact or a paragraph.
/// Without a title, the card shows only the body text.
///
/// The card is static by default. To make it selectable, use it as the label of a button with the
/// ``EntryCardButtonStyle`` style. A selectable card shows a disclosure chevron.
///
/// ```swift
/// EntryCard(configuration: .init(title: "Languages", description: "Ukrainian, English"))
///
/// Button(action: openSkills) {
///     EntryCard(configuration: .init(title: "Skills"))
/// }
/// .buttonStyle(.entryCard)
/// .entryCardSelected(isSkillsSelected)
/// ```
public struct EntryCard: View {

    /// Creates a card that shows the text of a configuration.
    ///
    /// - Parameter configuration: The title and the description of the card.
    public init(configuration: EntryCardConfiguration) {
        self.configuration = configuration
    }

    public var body: some View {
        HStack(spacing: Spacing.s) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                if let title = configuration.title {
                    Text(verbatim: title)
                        .typography(hasDescription ? .Interface.headline : .Interface.buttonLarge)
                }

                if let description = configuration.description {
                    Text(verbatim: description)
                        .typography(.Interface.body)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if appearance.showsDisclosureIndicator {
                Image(systemName: Constants.disclosureIndicatorSymbolName)
                    .typography(.Interface.footnoteSemibold)
                    .foregroundStyle(Colors.neonCyan.swiftUIColor)
                    .accessibilityHidden(true)
            }
        }
        .foregroundStyle(Colors.textPrimary.swiftUIColor)
        .multilineTextAlignment(.leading)
        .padding(.horizontal, Spacing.m)
        .padding(.vertical, hasDescription ? Spacing.m : Spacing.s)
        .frame(minHeight: hasDescription ? nil : Spacing.xxl)
        .rounded(.xl)
        .backgroundGlass(tint: appearance.tintColor, isInteractive: appearance.isInteractive)
        .border(color: appearance.strokeColor, lineWidth: .m, isEnabled: showsBorder)
        .boxShadow(appearance.glow)
        .contentShape(.rect(cornerRadius: CornerRadius.xl.rawValue))
    }

    // MARK: - Private Properties

    private let configuration: EntryCardConfiguration

    @Environment(\.entryCardAppearance)
    private var interactiveAppearance

    private var appearance: EntryCardAppearance {
        interactiveAppearance ?? .plain
    }

    /// A Boolean value that indicates whether the card shows body text.
    private var hasDescription: Bool {
        configuration.description != nil
    }

    /// A Boolean value that indicates whether the card draws its rim.
    ///
    /// On iOS 26 and later, the native glass draws its own edge, so the card does not draw a rim.
    private var showsBorder: Bool {
        if #available(iOS 26, *) {
            return false
        }
        return true
    }

    // MARK: - Constants

    private enum Constants {

        /// The SF Symbol of the disclosure chevron.
        static let disclosureIndicatorSymbolName = "chevron.right"
    }
}

#Preview("Static") {
    VStack(spacing: Spacing.l) {
        EntryCard(configuration: .init(title: "Languages", description: "Ukrainian, English"))
        EntryCard(configuration: .init(title: "Music production"))
        EntryCard(
            configuration: .init(description: "Shipped on-device image classification in a banking onboarding flow.")
        )
    }
    .padding(Spacing.m)
    .frame(maxHeight: .infinity)
    .background(Colors.bg100.swiftUIColor)
}

#Preview("Selectable") {
    @Previewable @State var selection = "Objective & summary"
    let sections = ["Contacts", "Objective & summary", "Skills"]

    VStack(spacing: Spacing.xs) {
        ForEach(sections, id: \.self) { section in
            Button {
                selection = section
            } label: {
                EntryCard(configuration: .init(title: section))
            }
            .buttonStyle(.entryCard)
            .entryCardSelected(selection == section)
        }

        Button {} label: {
            EntryCard(
                configuration: .init(
                    title: "Objective",
                    description: "I wish to grow as an iOS developer and lead a team."
                )
            )
        }
        .buttonStyle(.entryCard)
        .padding(.top, Spacing.l)
    }
    .padding(Spacing.m)
    .frame(maxHeight: .infinity)
    .background(Colors.bg100.swiftUIColor)
}
