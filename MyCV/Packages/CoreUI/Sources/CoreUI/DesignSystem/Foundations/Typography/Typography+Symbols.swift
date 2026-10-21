//
//  Typography+Symbols.swift
//  CoreUI
//
//  Created by Dmytro Dobrovolskyi on 21.10.2026.
//

import SwiftUI

extension Typography {

    public enum Display {

        /// Hero title (start screen name).
        public static let large = Typography(
            font: .systemFont(ofSize: 50), weight: .semibold, textStyle: .largeTitle, lineHeight: 60
        )

        /// Decorative title (start screen greeting).
        public static let decorative = Typography(
            font: .chalkduster(ofSize: 24), weight: .regular, textStyle: .title, lineHeight: 32
        )
    }

    public enum Heading {

        public enum Level1 {

            /// H1 Light.
            public static let light = Typography(
                font: .systemFont(ofSize: 24), weight: .light, textStyle: .title, lineHeight: 30
            )

            /// H1 Medium.
            public static let medium = Typography(
                font: .systemFont(ofSize: 24), weight: .medium, textStyle: .title, lineHeight: 30
            )

            /// H1 Bold.
            public static let bold = Typography(
                font: .systemFont(ofSize: 24), weight: .bold, textStyle: .title, lineHeight: 30
            )
        }

        public enum Level2 {

            /// H2 Light.
            public static let light = Typography(
                font: .systemFont(ofSize: 20), weight: .light, textStyle: .title3, lineHeight: 26
            )

            /// H2 Medium.
            public static let medium = Typography(
                font: .systemFont(ofSize: 20), weight: .medium, textStyle: .title3, lineHeight: 26
            )

            /// H2 Bold.
            public static let bold = Typography(
                font: .systemFont(ofSize: 20), weight: .bold, textStyle: .title3, lineHeight: 26
            )
        }

        public enum Level3 {

            /// H3 Light.
            public static let light = Typography(
                font: .systemFont(ofSize: 17), weight: .light, textStyle: .headline, lineHeight: 22
            )

            /// H3 Medium.
            public static let medium = Typography(
                font: .systemFont(ofSize: 17), weight: .medium, textStyle: .headline, lineHeight: 22
            )

            /// H3 Bold.
            public static let bold = Typography(
                font: .systemFont(ofSize: 17), weight: .semibold, textStyle: .headline, lineHeight: 22
            )
        }
    }

    public enum Paragraph {

        public enum Level1 {

            /// P1 Light.
            public static let light = Typography(
                font: .systemFont(ofSize: 17), weight: .light, textStyle: .body, lineHeight: 24
            )

            /// P1 Regular.
            public static let regular = Typography(
                font: .systemFont(ofSize: 17), weight: .regular, textStyle: .body, lineHeight: 24
            )

            /// P1 Bold.
            public static let bold = Typography(
                font: .systemFont(ofSize: 17), weight: .bold, textStyle: .body, lineHeight: 24
            )
        }

        public enum Level2 {

            /// P2 Light.
            public static let light = Typography(
                font: .systemFont(ofSize: 15), weight: .light, textStyle: .subheadline, lineHeight: 20
            )

            /// P2 Regular.
            public static let regular = Typography(
                font: .systemFont(ofSize: 15), weight: .regular, textStyle: .subheadline, lineHeight: 20
            )

            /// P2 Bold.
            public static let bold = Typography(
                font: .systemFont(ofSize: 15), weight: .bold, textStyle: .subheadline, lineHeight: 20
            )
        }

        public enum Level3 {

            /// P3 Light.
            public static let light = Typography(
                font: .systemFont(ofSize: 13), weight: .light, textStyle: .footnote, lineHeight: 18
            )

            /// P3 Regular.
            public static let regular = Typography(
                font: .systemFont(ofSize: 13), weight: .regular, textStyle: .footnote, lineHeight: 18
            )

            /// P3 Bold.
            public static let bold = Typography(
                font: .systemFont(ofSize: 13), weight: .bold, textStyle: .footnote, lineHeight: 18
            )
        }
    }

    public enum Quote {

        /// Quote L (skills list).
        public static let large = Typography(
            font: .gillSansItalic(ofSize: 20), weight: .regular, textStyle: .body, lineHeight: 26
        )

        /// Quote M (education courses).
        public static let medium = Typography(
            font: .gillSansItalic(ofSize: 18), weight: .regular, textStyle: .body, lineHeight: 24
        )

        /// Quote S (summary text).
        public static let small = Typography(
            font: .gillSansItalic(ofSize: 17), weight: .regular, textStyle: .body, lineHeight: 22
        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    VStack {
        GroupBox {
            Text("Display Large")
                .typography(.Display.large)
            Text("Display Decorative")
                .typography(.Display.decorative)
        }
        GroupBox {
            Text("H1 Bold")
                .typography(.Heading.Level1.bold)
            Text("H1 Medium")
                .typography(.Heading.Level1.medium)
            Text("H1 Light")
                .typography(.Heading.Level1.light)
        }
        GroupBox {
            Text("H2 Bold")
                .typography(.Heading.Level2.bold)
            Text("H2 Medium")
                .typography(.Heading.Level2.medium)
            Text("H2 Light")
                .typography(.Heading.Level2.light)
        }
        GroupBox {
            Text("H3 Bold")
                .typography(.Heading.Level3.bold)
            Text("H3 Medium")
                .typography(.Heading.Level3.medium)
            Text("H3 Light")
                .typography(.Heading.Level3.light)
        }
        GroupBox {
            Text("P1 Light")
                .typography(.Paragraph.Level1.light)
            Text("P1 Regular")
                .typography(.Paragraph.Level1.regular)
            Text("P1 Bold")
                .typography(.Paragraph.Level1.bold)
        }
        GroupBox {
            Text("P2 Light")
                .typography(.Paragraph.Level2.light)
            Text("P2 Regular")
                .typography(.Paragraph.Level2.regular)
            Text("P2 Bold")
                .typography(.Paragraph.Level2.bold)
        }
        GroupBox {
            Text("P3 Light")
                .typography(.Paragraph.Level3.light)
            Text("P3 Regular")
                .typography(.Paragraph.Level3.regular)
            Text("P3 Bold")
                .typography(.Paragraph.Level3.bold)
        }
        GroupBox {
            Text("Quote L")
                .typography(.Quote.large)
            Text("Quote M")
                .typography(.Quote.medium)
            Text("Quote S")
                .typography(.Quote.small)
        }
    }
    .fixedSize()
    .padding()
}
