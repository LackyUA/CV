//
//  UIFont+CV.swift
//  CoreUI
//
//  Created by Dmytro Dobrovolskyi on 21.10.2026.
//

import UIKit

extension UIFont {

    static func gillSansItalic(ofSize size: CGFloat) -> UIFont {
        builtIn(name: "GillSans-Italic", size: size)
    }

    static func chalkduster(ofSize size: CGFloat) -> UIFont {
        builtIn(name: "Chalkduster", size: size)
    }

    // MARK: - Private

    private static func builtIn(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            assertionFailure("Unable to find font: \(name).")
            return .systemFont(ofSize: size)
        }
        return font
    }
}
