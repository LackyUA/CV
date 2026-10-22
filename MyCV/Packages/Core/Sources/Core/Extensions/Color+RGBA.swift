//
//  Color+RGBA.swift
//  Core
//
//  Created by Andrii Vysotskyi on 01.07.2026.
//

import Foundation
import struct SwiftUI.Color

extension Color {

    /// Creates an sRGB color from a hexadecimal string.
    ///
    /// The initializer accepts `RRGGBB`, `AARRGGBB`, `#RRGGBB`, and `#AARRGGBB` values.
    /// When alpha is omitted, the color is treated as fully opaque.
    ///
    /// - NOTE: Returns `nil` when the string contains invalid hexadecimal characters or has an unsupported length.
    public init?(hex stringValue: String) {
        var stringValue = stringValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if stringValue.hasPrefix("#") {
            stringValue.removeFirst()
        }
        let scanner = Scanner(string: stringValue)
        var value: UInt64 = 0
        guard scanner.scanHexInt64(&value), scanner.isAtEnd else {
            return nil
        }
        // swiftlint:disable operator_usage_whitespace
        let red, green, blue, alpha: Double
        switch stringValue.count {
        case 6:
            alpha = 1
            red   = Double((value >> 16) & 0xFF) / 255
            green = Double((value >>  8) & 0xFF) / 255
            blue  = Double((value >>  0) & 0xFF) / 255
        case 8:
            alpha = Double((value >> 24) & 0xFF) / 255
            red   = Double((value >> 16) & 0xFF) / 255
            green = Double((value >>  8) & 0xFF) / 255
            blue  = Double((value >>  0) & 0xFF) / 255
        default:
            return nil
        }
        // swiftlint:enable operator_usage_whitespace
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
