//
//  ExperienceDetailsViewModelTests.swift
//  MyCVTests
//

import Foundation
import Testing
@testable import MyCV

@MainActor
struct ExperienceDetailsViewModelTests {

    @Test
    func openProjectOpensLink() {
        let viewModel = ExperienceDetailsViewModel(item: Self.item(link: "https://github.com/LackyUA/Road-signs"))
        var openedURL: URL?

        viewModel.openProject { openedURL = $0 }

        #expect(openedURL == URL(string: "https://github.com/LackyUA/Road-signs"))
        #expect(!viewModel.showsUnavailableAlert)
    }

    @Test
    func openProjectWithoutLinkShowsAlert() {
        let viewModel = ExperienceDetailsViewModel(item: Self.item(link: ""))
        var openedURL: URL?

        viewModel.openProject { openedURL = $0 }

        #expect(openedURL == nil)
        #expect(viewModel.showsUnavailableAlert)
    }

    // MARK: - Private Methods

    private static func item(link: String) -> ExperienceItem {
        ExperienceItem(id: 0, title: "Road signs", period: "2 months", link: link, description: "")
    }

}
