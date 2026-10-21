//
//  RootRouter.swift
//  MyCV
//

import SwiftUI

/// Root of the router graph. Owns the navigation path and builds the start screen and the section screens.
/// Child routers, such as `experienceRouter`, push onto the same path.
@MainActor
@Observable
final class RootRouter: Router {

    /// A screen that the root router can push.
    enum Route: Hashable {
        case section(CVSection)
    }

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
        experienceRouter = ExperienceRouter(service: service)
        experienceRouter.parent = self
    }

    /// Child router for the experience section. It shares this router's path.
    let experienceRouter: ExperienceRouter

    var path = NavigationPath()

    /// Builds the root screen of the stack.
    func rootView() -> some View {
        StartView(viewModel: StartViewModel(router: self))
    }

    @ViewBuilder
    func destination(for route: Route) -> some View {
        switch route {
        case .section(.contacts):
            ContactsView(viewModel: ContactsViewModel(service: service))
        case .section(.summary):
            SummaryView(viewModel: SummaryViewModel(service: service))
        case .section(.skills):
            SkillsView(viewModel: SkillsViewModel(service: service))
        case .section(.education):
            EducationView(viewModel: EducationViewModel(service: service))
        case .section(.experience):
            experienceRouter.rootView()
        case .section(.additional):
            AdditionalView(viewModel: AdditionalViewModel(service: service))
        }
    }

    // MARK: - Private Properties

    private let service: APIServiceProtocol
}
