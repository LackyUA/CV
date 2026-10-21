//
//  SourceShapeProviding+RoundedCorners.swift
//  CoreUI
//

import SwiftUI

extension RoundedCornersModifier: SourceShapeProviding {

    public nonisolated var sourceShape: RoundedRectangle {
        clipShape
    }
}
