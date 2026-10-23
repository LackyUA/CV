//
//  ContactCard.swift
//  CoreUI
//

import SwiftUI

/// A Liquid Glass card that joins a group of ``ContactRow`` views into one surface.
///
/// The card stacks its rows from top to bottom over one glass surface and draws a hairline between adjacent rows.
///
/// On iOS 26 and later, the card uses the native Liquid Glass effect. On earlier versions, it uses a backdrop blur
/// with a rim.
///
/// The glass is a separate layer behind the rows. Thus, a `Menu` in a row morphs only the content of the row,
/// and the glass stays in place while the menu is open.
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
public struct ContactCard<Content: View>: View {

    /// Creates a card that joins the rows of the content.
    ///
    /// - Parameter content: The rows of the card, from top to bottom. Each subview of the content is one row.
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: 0) {
            Group(subviews: content) { subviews in
                ForEach(Array(subviews.enumerated()), id: \.element.id) { index, subview in
                    subview
                        .overlay(alignment: .top) {
                            if index > 0 {
                                Colors.hairline.swiftUIColor
                                    .frame(height: BorderLineWidth.m.rawValue)
                                    .accessibilityHidden(true)
                            }
                        }
                }
            }
        }
        .contentShape(cardShape)
        .background {
            // If the glass wraps a menu, the menu takes the glass with it when it opens. The glass then shows
            // again only after a delay when the menu closes. A separate layer keeps the glass in the card.
            Color.clear
                .modifier(BackgroundGlassModifier(tint: nil, isInteractive: false, glassShape: cardShape))
        }
        .overlay {
            cardShape
                .stroke(Colors.glassStroke.swiftUIColor, lineWidth: BorderLineWidth.m.rawValue)
                .opacity(showsBorder ? 1 : 0)
        }
        .boxShadow(.glass, shape: cardShape)
    }

    // MARK: - Private Properties

    private let content: Content

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: CornerRadius.xl.rawValue)
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
}

#Preview {
    VStack(spacing: Spacing.l) {
        ContactCard {
            ContactRow(configuration: .init(title: "Address", value: "Ivano-Frankivsk"))

            Menu {
                Button("Copy", systemImage: "doc.on.doc") {}
                Button("Call", systemImage: "phone") {}
            } label: {
                ContactRow(
                    configuration: .init(
                        title: "Mobile",
                        value: "+380 (00) 0000 000",
                        icon: Image(decorative: Images.call)
                    )
                )
            }

            Menu {
                Button("Copy", systemImage: "doc.on.doc") {}
                Button("Open", systemImage: "safari") {}
            } label: {
                ContactRow(
                    configuration: .init(title: "Git", value: "github.com/LackyUA", icon: Image(decorative: Images.web))
                )
            }
        }

        ContactCard {
            ContactRow(configuration: .init(title: "E-mail", value: "name@example.com"))
        }
    }
    .padding(Spacing.m)
    .frame(maxHeight: .infinity)
    .background(Colors.bg100.swiftUIColor)
}
