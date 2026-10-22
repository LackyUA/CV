//
//  EntryCard.swift
//  CoreUI
//

import SwiftUI

/// A Liquid Glass card that shows a title and an optional description.
///
/// On iOS 26 and later, the card uses the native Liquid Glass effect. On earlier versions, it uses a backdrop blur.
///
/// Without a description, the card shows a larger title in a compact card, for example a menu item.
/// With a description, the card shows a headline over body text, for example a CV fact or a paragraph.
///
/// The card is static by default. To make it selectable, use it as the label of a button with the
/// ``EntryCardButtonStyle`` style. A selectable card shows a disclosure chevron.
///
/// ```swift
/// EntryCard(verbatim: "Languages", description: "Ukrainian, English")
///
/// Button(action: openSkills) {
///     EntryCard(verbatim: "Skills")
/// }
/// .buttonStyle(.entryCard)
/// .entryCardSelected(isSkillsSelected)
/// ```
public struct EntryCard: View {

    /// Creates a card with a localized title and an optional localized description.
    ///
    /// - Parameters:
    ///   - title: The title of the card.
    ///   - description: The text under the title. The default value is `nil`, which shows the title only.
    public init(_ title: LocalizedStringResource, description: LocalizedStringResource? = nil) {
        self.title = Text(title)
        self.description = description.map { Text($0) }
    }

    /// Creates a card with a title and an optional description that the card shows without localization.
    ///
    /// - Parameters:
    ///   - title: The title of the card.
    ///   - description: The text under the title. The default value is `nil`, which shows the title only.
    public init(verbatim title: String, description: String? = nil) {
        self.title = Text(verbatim: title)
        self.description = description.map { Text(verbatim: $0) }
    }

    public var body: some View {
        HStack(spacing: Spacing.s) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                title
                    .typography(description == nil ? .Interface.buttonLarge : .Interface.headline)

                if let description {
                    description
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
        .padding(.vertical, description == nil ? Spacing.s : Spacing.m)
        .frame(minHeight: description == nil ? Spacing.xxl : nil)
        .rounded(.xl)
        .backgroundGlass(tint: appearance.tintColor, isInteractive: appearance.isInteractive)
        .border(color: appearance.strokeColor, lineWidth: .m, isEnabled: showsBorder)
        .boxShadow(appearance.glow)
        .contentShape(.rect(cornerRadius: CornerRadius.xl.rawValue))
    }

    // MARK: - Private Properties

    private let title: Text
    private let description: Text?

    @Environment(\.entryCardAppearance)
    private var interactiveAppearance

    private var appearance: EntryCardAppearance {
        interactiveAppearance ?? .plain
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
        EntryCard(verbatim: "Languages", description: "Ukrainian, English")
        EntryCard(verbatim: "Music production")
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
                EntryCard(verbatim: section)
            }
            .buttonStyle(.entryCard)
            .entryCardSelected(selection == section)
        }

        Button {} label: {
            EntryCard(verbatim: "Objective", description: "I wish to grow as an iOS developer and lead a team.")
        }
        .buttonStyle(.entryCard)
        .padding(.top, Spacing.l)
    }
    .padding(Spacing.m)
    .frame(maxHeight: .infinity)
    .background(Colors.bg100.swiftUIColor)
}
