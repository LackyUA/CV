//
//  TypographyPresenceKey.swift
//  CoreUI
//

import SwiftUI

/// A preference key that reports whether a view or one of its descendants applied a typography modifier.
///
/// The typography modifier reads this preference to apply its baseline adjustment only once.
struct TypographyPresenceKey: PreferenceKey {

    /// The source location where code applied a typography modifier.
    struct UsageContext: Equatable {
        let file: String, line: UInt
    }

    // MARK: - PreferenceKey

    static let defaultValue: [UsageContext] = []

    static func reduce(value: inout [UsageContext], nextValue: () -> [UsageContext]) {
        value.append(contentsOf: nextValue())
    }
}
