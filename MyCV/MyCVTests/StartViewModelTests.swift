//
//  StartViewModelTests.swift
//  MyCVTests
//

import Testing
@testable import MyCV

@MainActor
struct StartViewModelTests {

    @Test
    func selectPushesSection() {
        let router = RouterSpy<RootRouter.Route>()
        let viewModel = StartViewModel(router: router)

        viewModel.select(.skills)

        #expect(router.pushedRoutes == [.section(.skills)])
    }

}
