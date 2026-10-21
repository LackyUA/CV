//
//  ScaledViewSize+Icon.swift
//  CoreUI
//
//  Created by Andrii Vysotskyi on 14.07.2025.
//

import CoreGraphics

extension ScaledViewSize {

    /// Common icon sizes used throughout the UI.
    public enum Icon {

        /// Extra small icon size (16pt).
        public static let extraSmall = ScaledViewSize(rawValue: 16)

        /// Small icon size (20pt).
        public static let small = ScaledViewSize(rawValue: 20)

        /// Medium icon size (24pt).
        public static let medium = ScaledViewSize(rawValue: 24)

        /// Large icon size (32pt).
        public static let large = ScaledViewSize(rawValue: 32)

        /// Extra large icon size (40pt).
        public static let extraLarge = ScaledViewSize(rawValue: 40)

        /// Extra extra large icon size (48pt).
        public static let extraExtraLarge = ScaledViewSize(rawValue: 48)

        /// Triple extra large icon size (64pt).
        public static let extraExtraExtraLarge = ScaledViewSize(rawValue: 64)

        /// Quadruple extra large icon size (80pt).
        public static let extraExtraExtraExtraLarge = ScaledViewSize(rawValue: 80)
    }
}
