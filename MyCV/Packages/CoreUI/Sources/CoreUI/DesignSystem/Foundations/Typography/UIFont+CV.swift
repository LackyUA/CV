//
//  UIFont+CV.swift
//  CoreUI
//

import CoreText
import UIKit

extension UIFont {

    /// Returns Orbitron, the display face of the design system, at the given weight.
    ///
    /// The method selects the bundled Orbitron face that is closest to `weight`. Weights lighter than
    /// `regular` use the regular face. If the bundle does not contain the face, the method returns
    /// SF Pro Expanded at the same weight.
    static func orbitron(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        _ = FontRegistrar.registerBundledFonts
        if let font = UIFont(name: OrbitronFace(weight: weight).fontName, size: size) {
            return font
        }
        return .systemFont(ofSize: size, weight: weight, width: .expanded)
    }

    /// Returns SF Mono for HUD captions and figures.
    static func mono(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        .monospacedSystemFont(ofSize: size, weight: weight)
    }
}

// MARK: - Faces

/// The bundled Orbitron faces. Each raw value is the PostScript name of the font.
private enum OrbitronFace: String, CaseIterable {

    case regular = "Orbitron-Regular"
    case medium = "Orbitron-Medium"
    case semiBold = "Orbitron-SemiBold"
    case bold = "Orbitron-Bold"
    case extraBold = "Orbitron-ExtraBold"
    case black = "Orbitron-Black"

    /// Creates the face that is closest to the given weight.
    init(weight: UIFont.Weight) {
        switch weight.rawValue {
        case ..<UIFont.Weight.medium.rawValue:
            self = .regular
        case ..<UIFont.Weight.semibold.rawValue:
            self = .medium
        case ..<UIFont.Weight.bold.rawValue:
            self = .semiBold
        case ..<UIFont.Weight.heavy.rawValue:
            self = .bold
        case ..<UIFont.Weight.black.rawValue:
            self = .extraBold
        default:
            self = .black
        }
    }

    /// The PostScript name of the font.
    var fontName: String {
        rawValue
    }
}

// MARK: - Registration

/// Registers the bundled font files of the package with Core Text once per process.
private enum FontRegistrar {

    /// Registers the bundled font files. Read this value once before you load a bundled font.
    static let registerBundledFonts: Void = {
        for face in OrbitronFace.allCases {
            guard let url = Bundle.module.url(forResource: face.fontName, withExtension: "ttf") else {
                continue
            }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }()
}
