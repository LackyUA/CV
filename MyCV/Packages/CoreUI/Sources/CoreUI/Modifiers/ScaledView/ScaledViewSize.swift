//
//  ScaledViewSize.swift
//  CoreUI
//

import Foundation

public struct ScaledViewSize: RawRepresentable, Sendable {

    public init(rawValue: CGFloat) {
        self.rawValue = rawValue
    }

    public let rawValue: CGFloat
}
