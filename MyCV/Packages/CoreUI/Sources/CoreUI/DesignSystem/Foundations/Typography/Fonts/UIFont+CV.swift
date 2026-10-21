//
//  UIFont+CV.swift
//  CoreUI
//

import CoreText
import UIKit

extension UIFont {

    /// Returns Orbitron, the display face of the design system, at the given weight.
    ///
    /// The method uses `Orbitron-Bold.ttf` (700) and `Orbitron-ExtraBold.ttf` (800) from `Assets/Resources/Fonts`.
    /// If these files are not available, the method returns SF Pro Expanded at the same weight.
    static func orbitron(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        _ = FontRegistrar.registerBundledFonts
        let name = weight.rawValue >= UIFont.Weight.heavy.rawValue ? "Orbitron-ExtraBold" : "Orbitron-Bold"
        if let font = UIFont(name: name, size: size) {
            return font
        }
        return .systemFont(ofSize: size, weight: weight, width: .expanded)
    }

    /// Returns SF Mono for HUD captions and figures.
    static func mono(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        .monospacedSystemFont(ofSize: size, weight: weight)
    }
}

// MARK: - Registration

/// Registers the package's bundled font files with Core Text once per process.
private enum FontRegistrar {

    /// Registers the bundled font files. Read this value once before you load a bundled font.
    static let registerBundledFonts: Void = {
        for name in fontFileNames {
            let url = Bundle.module.url(forResource: name, withExtension: "ttf")
                ?? Bundle.module.url(forResource: name, withExtension: "ttf", subdirectory: "Fonts")
            guard let url else {
                continue
            }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }()

    // MARK: - Private Properties

    private static let fontFileNames = ["Orbitron-Bold", "Orbitron-ExtraBold"]
}
