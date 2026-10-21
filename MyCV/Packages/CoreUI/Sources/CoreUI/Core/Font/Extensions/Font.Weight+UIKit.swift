//
//  Font.Weight+UIKit.swift
//  CoreUI
//

import SwiftUI

extension UIFont.Weight {

    init(_ weight: Font.Weight) {
        switch weight {
        case .ultraLight:
            self = .ultraLight
        case .thin:
            self = .thin
        case .light:
            self = .light
        case .regular:
            self = .regular
        case .medium:
            self = .medium
        case .semibold:
            self = .semibold
        case .bold:
            self = .bold
        case .heavy:
            self = .heavy
        case .black:
            self = .black
        default:
            self = .regular
        }
    }
}
