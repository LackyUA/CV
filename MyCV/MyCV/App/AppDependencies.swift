//
//  AppDependencies.swift
//  MyCV
//

import Core
import Services

/// Registers the dependencies of the application in a container.
enum AppDependencies {

    /// Registers every dependency. Call it one time before the first screen appears.
    static func register(in container: DependencyContainer = .shared) {
        container.register((any APIService).self) {
            ServiceBuilder.makeAPIService()
        }
    }
}
