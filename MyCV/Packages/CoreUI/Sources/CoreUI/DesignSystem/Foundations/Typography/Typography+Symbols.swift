//
//  Typography+Symbols.swift
//  CoreUI
//

import SwiftUI

/// Type scale mirrored from the MyCV design system (`tokens.json` → `type.groups`).
/// Tracking values are the design system's `letterSpacing` (em) multiplied by the font size.
extension Typography {

    /// Orbitron display styles. Always uppercase and tracked; never for sentences.
    public enum Display {

        /// `display-xl` — welcome title. Orbitron 800, 34/40, tracking 0.06em.
        public static let extraLarge = Typography(
            font: .orbitron(ofSize: 34, weight: .heavy), weight: .heavy, textStyle: .largeTitle,
            lineHeight: 40, tracking: 2.04, isUppercased: true
        )

        /// `display-name` — owner's name under the profile badge. Orbitron 700, 24/30, tracking 0.08em.
        public static let name = Typography(
            font: .orbitron(ofSize: 24, weight: .bold), weight: .bold, textStyle: .title,
            lineHeight: 30, tracking: 1.92, isUppercased: true
        )

        /// `orb-label` — label inside the Start orb. Orbitron 800, 26/32, tracking 0.16em.
        public static let orb = Typography(
            font: .orbitron(ofSize: 26, weight: .heavy), weight: .heavy, textStyle: .title,
            lineHeight: 32, tracking: 4.16, isUppercased: true
        )

        /// `section-title` — list section headers. Orbitron 700, 13/18, tracking 0.2em.
        public static let sectionTitle = Typography(
            font: .orbitron(ofSize: 13, weight: .bold), weight: .bold, textStyle: .footnote,
            lineHeight: 18, tracking: 2.6, isUppercased: true
        )
    }

    /// SF Pro styles for everything that is read.
    public enum Interface {

        /// `button-lg` — section capsules and the primary button. 19/24 semibold.
        public static let buttonLarge = Typography(
            font: .systemFont(ofSize: 19), weight: .semibold, textStyle: .body, lineHeight: 24
        )

        /// `nav-title` — inline navigation title. 17/22 semibold.
        public static let navTitle = Typography(
            font: .systemFont(ofSize: 17), weight: .semibold, textStyle: .headline, lineHeight: 22
        )

        /// `segment` — segmented control labels. 15/20 semibold.
        public static let segment = Typography(
            font: .systemFont(ofSize: 15), weight: .semibold, textStyle: .subheadline, lineHeight: 20
        )

        /// `title3` — centred single statements. 20/26 medium.
        public static let title3 = Typography(
            font: .systemFont(ofSize: 20), weight: .medium, textStyle: .title3, lineHeight: 26
        )

        /// `headline` — entry titles. 17/22 semibold.
        public static let headline = Typography(
            font: .systemFont(ofSize: 17), weight: .semibold, textStyle: .headline, lineHeight: 22
        )

        /// `body` — default text: rows, values, paragraphs. 17/24 regular.
        public static let body = Typography(
            font: .systemFont(ofSize: 17), weight: .regular, textStyle: .body, lineHeight: 24
        )

        /// `footnote` — small supporting text. 13/18 regular.
        public static let footnote = Typography(
            font: .systemFont(ofSize: 13), weight: .regular, textStyle: .footnote, lineHeight: 18
        )
    }

    /// SF Mono HUD styles for captions and figures.
    public enum HUD {

        /// `hud-label` — field captions and HUD tags. SF Mono 11/14 semibold, tracking 0.18em, uppercase.
        public static let label = Typography(
            font: .mono(ofSize: 11, weight: .semibold), weight: .semibold, textStyle: .caption2,
            lineHeight: 14, tracking: 1.98, isUppercased: true
        )

        /// `hud-value` — figures and short codes. SF Mono 13/18 medium, tracking 0.04em.
        public static let value = Typography(
            font: .mono(ofSize: 13, weight: .medium), weight: .medium, textStyle: .footnote,
            lineHeight: 18, tracking: 0.52
        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    VStack(alignment: .leading) {
        GroupBox {
            Text("My CV")
                .typography(.Display.extraLarge)
            Text("Dobrovolskyy")
                .typography(.Display.name)
            Text("Start")
                .typography(.Display.orb)
            Text("Languages")
                .typography(.Display.sectionTitle)
        }
        GroupBox {
            Text("Button Large")
                .typography(.Interface.buttonLarge)
            Text("Navigation Title")
                .typography(.Interface.navTitle)
            Text("Segment")
                .typography(.Interface.segment)
            Text("Title 3")
                .typography(.Interface.title3)
            Text("Headline")
                .typography(.Interface.headline)
            Text("Body")
                .typography(.Interface.body)
            Text("Footnote")
                .typography(.Interface.footnote)
        }
        GroupBox {
            Text("Mobile")
                .typography(.HUD.label)
            Text("2 months")
                .typography(.HUD.value)
        }
    }
    .fixedSize()
    .padding()
}
