//
//  SourceShapeProviding+RoundedCorners.swift
//  CoreUI
//
//  Created by Andrii Vysotskyi on 23.06.2025.
//

import SwiftUI

extension RoundedCornersModifier: SourceShapeProviding {

    public nonisolated var sourceShape: RoundedRectangle {
        clipShape
    }
}
