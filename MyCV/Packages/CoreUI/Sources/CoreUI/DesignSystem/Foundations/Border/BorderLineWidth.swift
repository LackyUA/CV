//
//  BorderLineWidth.swift
//  CoreUI
//
import Foundation

public struct BorderLineWidth: Sendable, Equatable {

    /// Raw value.
    let rawValue: CGFloat
}

// swiftlint:disable identifier_name

extension BorderLineWidth {

    /// 1 pt.
    public static let m = BorderLineWidth(rawValue: 1)

    /// 2 pt.
    public static let l = BorderLineWidth(rawValue: 2)
}

// swiftlint:enable identifier_name
