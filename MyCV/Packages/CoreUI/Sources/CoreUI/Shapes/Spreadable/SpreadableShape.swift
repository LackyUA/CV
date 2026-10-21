//
//  SpreadableShape.swift
//  CoreUI
//
//  Created by Andrii Vysotskyi on 20.06.2025.
//

import SwiftUI

public protocol SpreadableShape: Shape {

    /// The type of the spread shape.
    associatedtype SpreadShape: SpreadableShape

    /// Returns `self` spread by `amount`.
    nonisolated func spread(by amount: CGFloat) -> SpreadShape
}
