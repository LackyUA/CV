//
//  ExperienceViewModelTests.swift
//  MyCVTests
//

import Services
import Testing
@testable import MyCV

@MainActor
struct ExperienceViewModelTests {

    @Test
    func selectPushesDetails() {
        let router = RouterSpy<ExperienceRouter.Route>()
        let viewModel = ExperienceViewModel(service: ServiceBuilder.makeAPIService(), router: router)
        let item = ExperienceItem(id: 0, title: "Gym", period: "4 months", link: "", description: "")

        viewModel.select(item)

        #expect(router.pushedRoutes == [.details(item)])
    }

}
