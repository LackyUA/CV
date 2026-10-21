//
//  ModifiedContent+SourceShapeProviding.swift
//  CoreUI
//
//  Created by Andrii Vysotskyi on 24.06.2025.
//

import SwiftUI

extension ModifiedContent: SourceShapeProviding where Modifier: SourceShapeProviding {

    public var sourceShape: Modifier.SourceShape {
        modifier.sourceShape
    }
}
