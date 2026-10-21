//
//  SpreadableShape.swift
//  CoreUI
//

import SwiftUI

public protocol SpreadableShape: Shape {

    /// The type of the spread shape.
    associatedtype SpreadShape: SpreadableShape

    /// Returns `self` spread by `amount`.
    nonisolated func spread(by amount: CGFloat) -> SpreadShape
}
