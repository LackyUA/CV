//
//  DependencyScope.swift
//  Core
//

/// The lifetime of a dependency in a `DependencyContainer`.
public enum DependencyScope: Sendable {

    /// The container creates one instance and returns it for every resolution.
    case singleton

    /// The container creates a new instance for every resolution.
    case transient
}
