//
//  ScaledViewSize.swift
//  CoreUI
//
//  Created by Andrii Vysotskyi on 14.07.2025.
//

import Foundation

public struct ScaledViewSize: RawRepresentable, Sendable {

    public init(rawValue: CGFloat) {
        self.rawValue = rawValue
    }

    public let rawValue: CGFloat
}
