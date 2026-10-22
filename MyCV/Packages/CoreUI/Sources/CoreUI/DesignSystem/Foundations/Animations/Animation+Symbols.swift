//
//  Animation+Symbols.swift
//  CoreUI
//

import SwiftUI

/// The animations of the MyCV design system.
extension Animation {

    /// The spring that scales a control when the user presses or releases it.
    public static let press: Animation = .spring(response: 0.45, dampingFraction: 0.8)
}
