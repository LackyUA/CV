//
//  View+SetTypographyPresent.swift
//  CoreUI
//
//  Created by Andrii Vysotskyi on 06.06.2025.
//

import SwiftUI

extension View {

    /// Marks the current view as having applied a typography modifier by emitting
    /// a `TypographyPresenceKey` preference with debug context.
    @ViewBuilder
    func setTypographyPresent(context: TypographyPresenceKey.UsageContext) -> some View {
        preference(key: TypographyPresenceKey.self, value: [context])
    }
}
