//
//  View+SetTypographyPresent.swift
//  CoreUI
//

import SwiftUI

extension View {

    /// Reports that the view applied a typography modifier.
    ///
    /// The method emits a `TypographyPresenceKey` preference that contains the source location.
    @ViewBuilder
    func setTypographyPresent(context: TypographyPresenceKey.UsageContext) -> some View {
        preference(key: TypographyPresenceKey.self, value: [context])
    }
}
