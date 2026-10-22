//
//  RootRouter.swift
//  MyCV
//

import Core
import Services
import SwiftUI

/// Root of the router graph. Owns the navigation path and builds the start screen and the section screens.
/// Child routers, such as `experienceRouter`, push onto the same path.
/// The router is the composition root: it resolves the service from the container and passes it to the start screen.
@MainActor
@Observable
final class RootRouter: Router {

    /// A screen that the root router can push.
    enum Route: Hashable {

        /// The screen of a CV section. The section carries the data that the screen shows.
        case section(ContentSection)
    }

    init(service: APIService = DependencyContainer.shared.resolve((any APIService).self)) {
        self.service = service
        experienceRouter = ExperienceRouter()
        experienceRouter.parent = self
    }

    /// Child router for the experience section. It shares this router's path.
    let experienceRouter: ExperienceRouter

    var path = NavigationPath()

    /// Builds the root screen of the stack.
    func rootView() -> some View {
        StartView(viewModel: StartViewModel(service: service, router: self))
    }

    @ViewBuilder
    func destination(for route: Route) -> some View {
        switch route {
        case .section(.contacts(let contacts)):
            ContactsView(viewModel: ContactsViewModel(contacts: contacts))
        case .section(.summary(let summary)):
            SummaryView(viewModel: SummaryViewModel(summary: summary))
        case .section(.skills(let skills)):
            SkillsView(viewModel: SkillsViewModel(skills: skills))
        case .section(.education(let education)):
            EducationView(viewModel: EducationViewModel(education: education))
        case .section(.experience(let experience)):
            experienceRouter.rootView(experience: experience)
        case .section(.additional(let additional)):
            AdditionalView(viewModel: AdditionalViewModel(additional: additional))
        }
    }

    // MARK: - Private Properties

    private let service: APIService
}
