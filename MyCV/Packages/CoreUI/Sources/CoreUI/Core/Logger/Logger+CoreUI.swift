//
//  Logger+CoreUI.swift
//  CoreUI
//

import OSLog

extension Logger {

    /// Creates a logger scoped to the core UI subsystem with the given category.
    init(coreUiCategory category: String) {
        self.init(subsystem: "com.mycv.CoreUI", category: category)
    }
}
