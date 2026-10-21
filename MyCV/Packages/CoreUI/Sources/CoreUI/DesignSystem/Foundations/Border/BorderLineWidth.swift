//
//  BorderLineWidth.swift
//  CoreUI
//

import Foundation

/// Border line width symbols.
public struct BorderLineWidth: RawRepresentable, Sendable {

    public init(rawValue: CGFloat) {
        self.rawValue = rawValue
    }

    public let rawValue: CGFloat
}

// swiftlint:disable identifier_name

extension BorderLineWidth {

    /// 1 pt.
    public static let m = BorderLineWidth(rawValue: 1)

    /// 2 pt.
    public static let l = BorderLineWidth(rawValue: 2)
}

// swiftlint:enable identifier_name
