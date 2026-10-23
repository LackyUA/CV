//
//  SystemActions.swift
//  MyCV
//

import Foundation

/// Sends data to the system outside the app, such as the pasteboard or another app.
@MainActor
protocol SystemActions {

    /// Puts text on the general pasteboard.
    func copy(_ text: String)

    /// Opens a URL in the app that handles it, such as Safari for a web page or Phone for a `tel` URL.
    func open(_ url: URL)
}
