//
//  SystemActionsSpy.swift
//  ApplicationTests
//

import Foundation
@testable import Application

/// Records the text that a view model copies and the URLs that it opens.
@MainActor
final class SystemActionsSpy: SystemActions {

    private(set) var copiedTexts: [String] = []

    private(set) var openedURLs: [URL] = []

    func copy(_ text: String) {
        copiedTexts.append(text)
    }

    func open(_ url: URL) {
        openedURLs.append(url)
    }
}
