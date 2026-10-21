//
//  ExperienceRouter.swift
//  MyCV
//

import SwiftUI

/// Router for the experience section. Builds the experience list and pushes the details screen.
@MainActor
@Observable
final class ExperienceRouter: Router {

    /// A screen that the experience router can push.
    enum Route: Hashable {
        case details(ExperienceItem)
    }

    init(service: APIServiceProtocol) {
        self.service = service
    }

    /// The router that owns the navigation path. The parent sets it when it adds this router to the graph.
    @ObservationIgnored weak var parent: (any Router)?

    /// Forwards to the parent's path, so this router pushes onto the shared stack.
    var path: NavigationPath {
        get { parent?.path ?? NavigationPath() }
        set { parent?.path = newValue }
    }

    /// Builds the experience list and registers the screens that this router can push.
    func rootView() -> some View {
        ExperienceView(viewModel: ExperienceViewModel(service: service, router: self))
            .navigationDestinations(of: self)
    }

    @ViewBuilder
    func destination(for route: Route) -> some View {
        switch route {
        case .details(let item):
            ExperienceDetailsView(viewModel: ExperienceDetailsViewModel(item: item))
        }
    }

    // MARK: - Private Properties

    private let service: APIServiceProtocol

}
