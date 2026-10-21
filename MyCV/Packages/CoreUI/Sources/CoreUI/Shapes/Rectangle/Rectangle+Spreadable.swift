//
//  Rectangle+Spreadable.swift
//  CoreUI
//

import SwiftUI

extension Rectangle: SpreadableShape {

    public func spread(by spread: CGFloat) -> some SpreadableShape {
        ModifiedShape(content: self, spread: spread)
    }
}

private struct ModifiedShape: SpreadableShape {

    let content: Rectangle, spread: CGFloat

    // MARK: - Shape

    func path(in rect: CGRect) -> Path {
        let insettedRect = rect.insetBy(dx: -spread, dy: -spread)
        return Rectangle().path(in: insettedRect)
    }

    // MARK: - SpreadableShape

    func spread(by amount: CGFloat) -> some SpreadableShape {
        Self(content: content, spread: spread + amount)
    }
}
