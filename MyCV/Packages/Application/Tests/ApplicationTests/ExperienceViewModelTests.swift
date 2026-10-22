//
//  ExperienceViewModelTests.swift
//  ApplicationTests
//

import Services
import Testing
@testable import Application

@MainActor
struct ExperienceViewModelTests {

    @Test
    func itemsFollowPositions() {
        let viewModel = ExperienceViewModel(experience: Self.experience, router: RouterSpy())

        #expect(viewModel.title == "Experience")
        #expect(viewModel.items.map(\.title) == ["Gym", "Road signs"])
    }

    @Test
    func selectPushesDetails() {
        let router = RouterSpy<ExperienceRouter.Route>()
        let viewModel = ExperienceViewModel(experience: Self.experience, router: router)
        let item = ExperienceItem(id: 0, title: "Gym", period: "4 months", link: "", description: "")

        viewModel.select(item)

        #expect(router.pushedRoutes == [.details(item)])
    }

    // MARK: - Private Properties

    private static let experience = Experience(
        title: "Experience",
        positions: [
            .init(name: "Gym", period: "4 months", link: "", description: ""),
            .init(name: "Road signs", period: "2 months", link: "", description: ""),
        ]
    )

}
