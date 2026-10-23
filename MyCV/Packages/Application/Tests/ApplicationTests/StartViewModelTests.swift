//
//  StartViewModelTests.swift
//  ApplicationTests
//

import Services
import Testing
@testable import Application

@MainActor
struct StartViewModelTests {

    @Test
    func selectPushesSection() {
        let router = RouterSpy<RootRouter.Route>()
        let viewModel = StartViewModel(service: APIServiceStub(content: Fixtures.content), router: router)

        viewModel.select(Fixtures.skills)

        #expect(router.pushedRoutes == [.section(Fixtures.skills)])
    }

    @Test
    func startShowsLoadedSections() async {
        let viewModel = StartViewModel(service: APIServiceStub(content: Fixtures.content), router: RouterSpy())
        viewModel.initiate()
        await viewModel.load()

        viewModel.start()
        viewModel.finishStart()

        #expect(Self.sectionTitles(of: viewModel) == ["Skills", "Education", "Experience"])
    }

    @Test
    func startWaitsForLoad() async {
        let viewModel = StartViewModel(service: APIServiceStub(content: Fixtures.content), router: RouterSpy())
        viewModel.initiate()
        viewModel.start()
        viewModel.finishStart()

        #expect(Self.sectionTitles(of: viewModel) == nil)

        await viewModel.load()

        #expect(Self.sectionTitles(of: viewModel) == ["Skills", "Education", "Experience"])
    }

    @Test
    func failedLoadShowsFailedState() async {
        let viewModel = StartViewModel(service: APIServiceStub(content: nil), router: RouterSpy())
        viewModel.initiate()
        await viewModel.load()

        viewModel.start()
        viewModel.finishStart()

        guard case .failed = viewModel.state else {
            Issue.record("Expected the failed state, got \(viewModel.state)")
            return
        }
    }

    @Test
    func selectButtonPushesItsSection() async {
        let router = RouterSpy<RootRouter.Route>()
        let viewModel = StartViewModel(service: APIServiceStub(content: Fixtures.content), router: router)
        viewModel.initiate()
        await viewModel.load()
        viewModel.start()
        viewModel.finishStart()

        guard case .started(let currentState) = viewModel.state else {
            Issue.record("Expected the started state, got \(viewModel.state)")
            return
        }
        currentState.configuration.panel.sections.sections[1].select()

        #expect(router.pushedRoutes == [.section(Fixtures.education)])
    }

    // MARK: - Private Methods

    /// The titles of the section buttons, or `nil` when the screen is not in the started state.
    private static func sectionTitles(of viewModel: StartViewModel) -> [String]? {
        guard case .started(let currentState) = viewModel.state else {
            return nil
        }
        return currentState.configuration.panel.sections.sections.compactMap(\.card.title)
    }

}
