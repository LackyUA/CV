//
//  CornerRadius.swift
//  CoreUI
//

import Foundation

// swiftlint:disable identifier_name

/// Corner radius symbols.
public struct CornerRadius: RawRepresentable, Sendable {

    public init(rawValue: CGFloat) {
        self.rawValue = rawValue
    }

    public let rawValue: CGFloat
}

extension CornerRadius {

    /// Zero corner radius.
    public static let zero = CornerRadius(rawValue: 0)

    /// 2 pt.
    public static let xxs = CornerRadius(rawValue: 2)

    /// 4 pt.
    public static let xs = CornerRadius(rawValue: 4)

    /// 8 pt.
    public static let s = CornerRadius(rawValue: 8)

    /// 12 pt.
    public static let m = CornerRadius(rawValue: 12)

    /// 16 pt.
    public static let l = CornerRadius(rawValue: 16)

    /// 24 pt.
    public static let xl = CornerRadius(rawValue: 24)

    /// 32 pt.
    public static let xxl = CornerRadius(rawValue: 32)

    /// Infinite corner radius.
    public static let infinity = CornerRadius(rawValue: 99999)
}

// swiftlint:enable identifier_name
