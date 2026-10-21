//
//  TypographyPresenceKey.swift
//  CoreUI
//

import SwiftUI

/// A `PreferenceKey` used to indicate whether a view or any of its descendants
/// has applied a typography modifier. This is used to prevent multiple applications
/// of cumulative typography effects.
struct TypographyPresenceKey: PreferenceKey {

    /// Represents the source location in code where a typography modifier was applied.
    struct UsageContext: Equatable {
        let file: String, line: UInt
    }

    // MARK: - PreferenceKey

    static let defaultValue: [UsageContext] = []

    static func reduce(value: inout [UsageContext], nextValue: () -> [UsageContext]) {
        value.append(contentsOf: nextValue())
    }
}
