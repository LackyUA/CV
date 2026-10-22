//
//  DependencyContainerTests.swift
//  MyCVTests
//

import Core
import Testing

struct DependencyContainerTests {

    @Test
    func singletonResolvesToSameInstance() {
        let container = DependencyContainer()
        container.register((any Greeter).self) { EnglishGreeter() }

        let first = container.resolve((any Greeter).self)
        let second = container.resolve((any Greeter).self)

        #expect(first === second)
        #expect(first.greeting == "Hello")
    }

    @Test
    func transientResolvesToNewInstance() {
        let container = DependencyContainer()
        container.register((any Greeter).self, scope: .transient) { EnglishGreeter() }

        let first = container.resolve((any Greeter).self)
        let second = container.resolve((any Greeter).self)

        #expect(first !== second)
    }

    @Test
    func unregisteredTypeResolvesToNil() {
        let container = DependencyContainer()

        #expect(container.resolveIfRegistered((any Greeter).self) == nil)
    }

    @Test
    func laterRegistrationReplacesEarlier() {
        let container = DependencyContainer()
        container.register((any Greeter).self) { EnglishGreeter() }
        _ = container.resolve((any Greeter).self)

        container.register((any Greeter).self) { UkrainianGreeter() }

        #expect(container.resolve((any Greeter).self).greeting == "Привіт")
    }

    @Test
    func unregisterRemovesRegistration() {
        let container = DependencyContainer()
        container.register((any Greeter).self) { EnglishGreeter() }

        container.unregister((any Greeter).self)

        #expect(container.resolveIfRegistered((any Greeter).self) == nil)
    }

}

// MARK: - Doubles

private protocol Greeter: AnyObject, Sendable {
    var greeting: String { get }
}

private final class EnglishGreeter: Greeter {
    let greeting = "Hello"
}

private final class UkrainianGreeter: Greeter {
    let greeting = "Привіт"
}
