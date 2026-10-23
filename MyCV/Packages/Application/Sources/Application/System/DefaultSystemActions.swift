//
//  DefaultSystemActions.swift
//  MyCV
//

import UIKit

/// Sends data to the system through `UIPasteboard` and `UIApplication`.
struct DefaultSystemActions: SystemActions {

    func copy(_ text: String) {
        UIPasteboard.general.string = text
    }

    func open(_ url: URL) {
        UIApplication.shared.open(url)
    }
}
