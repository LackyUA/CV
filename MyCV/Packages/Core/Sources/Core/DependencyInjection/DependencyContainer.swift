//
//  DependencyContainer.swift
//  Core
//

import os

/// Registers factories for dependencies and resolves dependencies by type.
///
/// Register each dependency one time at launch. Resolve dependencies at the
/// composition root, such as a router, and pass them to the objects that use them.
public final class DependencyContainer: Sendable {

    /// The container of the application.
    public static let shared = DependencyContainer()

    public init() {}

    /// Registers a factory for a dependency type.
    ///
    /// A later registration for the same type replaces the earlier one and discards
    /// its singleton instance.
    public func register<Dependency: Sendable>(
        _ type: Dependency.Type,
        scope: DependencyScope = .singleton,
        factory: @escaping @Sendable () -> Dependency
    ) {
        registrations.withLock { registrations in
            registrations[ObjectIdentifier(type)] = Registration(scope: scope, factory: { factory() })
        }
    }

    /// Resolves a dependency. Stops the program if the type has no registration.
    public func resolve<Dependency: Sendable>(_ type: Dependency.Type) -> Dependency {
        guard let dependency = resolveIfRegistered(type) else {
            fatalError("DependencyContainer has no registration for \(type).")
        }
        return dependency
    }

    /// Resolves a dependency, or returns `nil` if the type has no registration.
    public func resolveIfRegistered<Dependency: Sendable>(_ type: Dependency.Type) -> Dependency? {
        let key = ObjectIdentifier(type)

        guard let registration = registrations.withLock({ $0[key] }) else {
            return nil
        }
        if let instance = registration.instance as? Dependency {
            return instance
        }

        // Call the factory outside the lock, because a factory can resolve other dependencies.
        guard let dependency = registration.factory() as? Dependency else {
            return nil
        }
        guard registration.scope == .singleton else {
            return dependency
        }

        return registrations.withLock { registrations in
            // Keep the first instance if another thread stored one in the meantime.
            if let existing = registrations[key]?.instance as? Dependency {
                return existing
            }
            registrations[key]?.instance = dependency
            return dependency
        }
    }

    /// Removes the registration of a dependency type.
    public func unregister<Dependency>(_ type: Dependency.Type) {
        registrations.withLock { registrations in
            registrations[ObjectIdentifier(type)] = nil
        }
    }

    /// Removes all registrations.
    public func removeAll() {
        registrations.withLock { registrations in
            registrations.removeAll()
        }
    }

    // MARK: - Private Properties

    private let registrations = OSAllocatedUnfairLock<[ObjectIdentifier: Registration]>(initialState: [:])
}

// MARK: - Registration

/// A registered factory and, for a singleton, the instance that it created.
private struct Registration: Sendable {

    /// The lifetime of the dependency. It decides whether the container keeps `instance`.
    let scope: DependencyScope

    /// Creates the dependency. The container calls it on each resolution for a transient
    /// dependency and on the first resolution for a singleton.
    let factory: @Sendable () -> any Sendable

    /// The instance of a singleton after its first resolution. It is `nil` before the
    /// first resolution and always `nil` for a transient dependency.
    var instance: (any Sendable)?
}
