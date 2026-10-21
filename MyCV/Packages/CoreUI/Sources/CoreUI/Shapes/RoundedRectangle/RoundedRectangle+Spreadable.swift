//
//  RoundedRectangle+Spreadable.swift
//  CoreUI
//
//  Created by Andrii Vysotskyi on 05.01.2026.
//

import SwiftUI

extension RoundedRectangle: SpreadableShape {

    public func spread(by spread: CGFloat) -> some SpreadableShape {
        ModifiedShape(content: self, spread: spread)
    }
}

private struct ModifiedShape: SpreadableShape {

    let content: RoundedRectangle, spread: CGFloat

    // MARK: - Shape

    func path(in rect: CGRect) -> Path {
        let insettedRect = rect.insetBy(dx: -spread, dy: -spread)
        let spreadSize = CGSize(
            width: max(content.cornerSize.width > 0.01 ? content.cornerSize.width + spread / 2 : 0, 0),
            height: max(content.cornerSize.height > 0.01 ? content.cornerSize.height + spread / 2 : 0, 0)
        )
        let modifiedContent = RoundedRectangle(cornerSize: spreadSize, style: content.style)
        return modifiedContent.path(in: insettedRect)
    }

    // MARK: - SpreadableShape

    func spread(by amount: CGFloat) -> some SpreadableShape {
        Self(content: content, spread: spread + amount)
    }
}
