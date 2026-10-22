//
//  RootRouterTests.swift
//  MyCVTests
//

import Core
import Services
import Testing
@testable import Application

@MainActor
struct RootRouterTests {

    init() {
        // The router resolves its service from the shared container, as the app does at launch.
        DependencyContainer.shared.register((any APIService).self) {
            ServiceBuilder.makeAPIService()
        }
    }

    @Test
    func pathStartsAtRoot() {
        let router = RootRouter()

        #expect(router.path.isEmpty)
    }

    @Test
    func pushAppendsRoute() {
        let router = RootRouter()

        router.push(.section(Fixtures.skills))

        #expect(router.path.count == 1)
    }

    @Test
    func popRemovesTopRoute() {
        let router = RootRouter()
        router.push(.section(Fixtures.skills))
        router.push(.section(Fixtures.education))

        router.pop()

        #expect(router.path.count == 1)
    }

    @Test
    func popOnRootKeepsPathEmpty() {
        let router = RootRouter()

        router.pop()

        #expect(router.path.isEmpty)
    }

    @Test
    func popToRootClearsPath() {
        let router = RootRouter()
        router.push(.section(Fixtures.experience))
        router.push(.section(Fixtures.skills))

        router.popToRoot()

        #expect(router.path.isEmpty)
    }

    @Test
    func childRouterPushesOntoSharedPath() {
        let router = RootRouter()
        router.push(.section(Fixtures.experience))

        router.experienceRouter.push(.details(Self.item))

        #expect(router.path.count == 2)
        #expect(router.experienceRouter.path.count == 2)
    }

    @Test
    func childRouterPopsSharedPath() {
        let router = RootRouter()
        router.push(.section(Fixtures.experience))
        router.experienceRouter.push(.details(Self.item))

        router.experienceRouter.pop()

        #expect(router.path.count == 1)
    }

    // MARK: - Private Properties

    private static let item = ExperienceItem(
        id: 0,
        title: "Road signs",
        period: "2 months",
        link: "",
        description: "Developed a program for learning road signs."
    )

}
