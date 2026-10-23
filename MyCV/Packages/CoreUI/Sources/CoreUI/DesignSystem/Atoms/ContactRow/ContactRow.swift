//
//  ContactRow.swift
//  CoreUI
//

import SwiftUI

/// A row that shows a contact caption, a contact value, and an optional icon.
///
/// The row has no background. Put rows in a ``ContactCard``, which joins the rows into one Liquid Glass card.
/// To show actions when the user taps a row, use the row as the label of a `Menu`.
///
/// ```swift
/// ContactCard {
///     ContactRow(configuration: .init(title: "Address", value: "Ivano-Frankivsk"))
///
///     Menu {
///         Button("Copy", systemImage: "doc.on.doc", action: copyNumber)
///     } label: {
///         ContactRow(configuration: .init(title: "Mobile", value: "+380 (00) 0000 000", icon: callIcon))
///     }
/// }
/// ```
public struct ContactRow: View {

    /// Creates a row that shows the content of a configuration.
    ///
    /// - Parameter configuration: The caption, the value, and the icon of the row.
    public init(configuration: ContactRowConfiguration) {
        self.configuration = configuration
    }

    public var body: some View {
        HStack(spacing: Spacing.s) {
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(verbatim: configuration.title)
                    .typography(.HUD.label)
                    .foregroundStyle(Colors.textSecondary.swiftUIColor)

                Text(verbatim: configuration.value)
                    .typography(.Interface.body)
                    .foregroundStyle(Colors.textPrimary.swiftUIColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if let icon = configuration.icon {
                icon
                    .scaled(idealWidth: .Icon.large, idealHeight: .Icon.large, relativeTo: .body)
            }
        }
        .multilineTextAlignment(.leading)
        .padding(.horizontal, Spacing.m)
        .padding(.vertical, Spacing.s)
        .frame(minHeight: Spacing.xxl)
        .contentShape(.rect)
        .accessibilityElement(children: .combine)
    }

    // MARK: - Private Properties

    private let configuration: ContactRowConfiguration
}

#Preview {
    VStack(spacing: Spacing.l) {
        ContactRow(configuration: .init(title: "Address", value: "Ivano-Frankivsk"))
        ContactRow(
            configuration: .init(title: "Mobile", value: "+380 (00) 0000 000", icon: Image(decorative: Images.call))
        )
    }
    .padding(Spacing.m)
    .frame(maxHeight: .infinity)
    .background(Colors.bg100.swiftUIColor)
}
