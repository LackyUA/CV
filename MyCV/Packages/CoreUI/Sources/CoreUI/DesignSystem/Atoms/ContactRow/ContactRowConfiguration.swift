//
//  ContactRowConfiguration.swift
//  CoreUI
//

import SwiftUI

/// The content that a ``ContactRow`` shows.
///
/// The row shows the text without localization. Resolve localized text into a `String` before you create the
/// configuration.
public struct ContactRowConfiguration: Equatable {

    /// Creates a configuration with a caption, a value, and an optional icon.
    ///
    /// - Parameters:
    ///   - title: The caption above the value, such as `Mobile`. The row shows it in uppercase.
    ///   - value: The contact value, such as a phone number.
    ///   - icon: The icon at the trailing edge of the row. The default value is `nil`, which shows no icon.
    public init(title: String, value: String, icon: Image? = nil) {
        self.title = title
        self.value = value
        self.icon = icon
    }

    /// The caption above the value.
    public let title: String

    /// The contact value.
    public let value: String

    /// The icon at the trailing edge of the row. The value is `nil` for a row without an icon.
    public let icon: Image?
}
