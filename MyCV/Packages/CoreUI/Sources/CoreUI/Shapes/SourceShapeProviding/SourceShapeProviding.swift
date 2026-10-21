//
//  SourceShapeProviding.swift
//  CoreUI
//
//  Created by Andrii Vysotskyi on 24.06.2025.
//

import SwiftUI

/// A type that provides a shape used to cast a shadow.
public protocol SourceShapeProviding<SourceShape> {

    /// The shape used as the base for shadow rendering.
    associatedtype SourceShape: Shape

    /// The source shape from which the shadow will be derived.
    var sourceShape: SourceShape { get }
}
