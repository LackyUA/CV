//
//  ModifiedContent+SourceShapeProviding.swift
//  CoreUI
//

import SwiftUI

extension ModifiedContent: SourceShapeProviding where Modifier: SourceShapeProviding {

    public var sourceShape: Modifier.SourceShape {
        modifier.sourceShape
    }
}
