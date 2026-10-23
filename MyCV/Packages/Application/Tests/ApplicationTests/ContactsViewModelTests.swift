//
//  ContactsViewModelTests.swift
//  ApplicationTests
//

import Foundation
import Services
import Testing
@testable import Application

@MainActor
struct ContactsViewModelTests {

    @Test
    func initiateShowsContactAndProfileCards() throws {
        let configuration = try Self.loadedConfiguration(of: Self.makeViewModel())

        #expect(configuration.sections.map(\.title) == ["Contact", "Profiles"])
        #expect(configuration.sections.map { $0.rows.map(\.row.title) } == [
            ["Address", "E-mail", "Mobile"],
            ["GitHub", "LinkedIn"],
        ])
    }

    @Test
    func rowsShowFormattedValues() throws {
        let configuration = try Self.loadedConfiguration(of: Self.makeViewModel())

        #expect(configuration.sections.flatMap(\.rows).map(\.row.value) == [
            "Ivano-Frankivsk, Ukraine",
            "name@example.com",
            "+380 (66) 8422 448",
            "github.com/LackyUA",
            "linkedin.com/in/d-dobrovolskyi",
        ])
    }

    @Test
    func mobileRowShowsUnmaskedNumberThatDoesNotAgreeWithMask() throws {
        let configuration = try Self.loadedConfiguration(of: Self.makeViewModel(mobile: "+48123456789"))

        #expect(try Self.row("Mobile", in: configuration).row.value == "+48123456789")
    }

    @Test
    func rowsHaveMenuActionsForTheirType() throws {
        let configuration = try Self.loadedConfiguration(of: Self.makeViewModel())

        #expect(configuration.sections.flatMap(\.rows).map { $0.actions.map(\.title) } == [
            ["Copy"],
            ["Copy"],
            ["Copy", "Call"],
            ["Copy", "Open"],
            ["Copy", "Open"],
        ])
    }

    @Test
    func copyActionsCopyFullValues() throws {
        let systemActions = SystemActionsSpy()
        let viewModel = Self.makeViewModel(systemActions: systemActions)
        let configuration = try Self.loadedConfiguration(of: viewModel)

        for row in configuration.sections.flatMap(\.rows) {
            try #require(row.actions.first).perform()
        }

        #expect(systemActions.copiedTexts == [
            "Ivano-Frankivsk, Ukraine",
            "name@example.com",
            "+380668422448",
            "https://github.com/LackyUA",
            "https://www.linkedin.com/in/d-dobrovolskyi/",
        ])
        withExtendedLifetime(viewModel) {}
    }

    @Test
    func callAndOpenActionsOpenURLs() throws {
        let systemActions = SystemActionsSpy()
        let viewModel = Self.makeViewModel(systemActions: systemActions)
        let configuration = try Self.loadedConfiguration(of: viewModel)

        for title in ["Mobile", "GitHub", "LinkedIn"] {
            try Self.row(title, in: configuration).actions[1].perform()
        }

        #expect(systemActions.openedURLs.map(\.absoluteString) == [
            "tel:+380668422448",
            "https://github.com/LackyUA",
            "https://www.linkedin.com/in/d-dobrovolskyi/",
        ])
        withExtendedLifetime(viewModel) {}
    }

    @Test
    func profileRowWithoutValidURLCanOnlyCopy() throws {
        let configuration = try Self.loadedConfiguration(of: Self.makeViewModel(git: "LackyUA"))

        #expect(try Self.row("GitHub", in: configuration).actions.map(\.title) == ["Copy"])
    }

    // MARK: - Private Methods

    private static func makeViewModel(
        mobile: String = "+380668422448",
        git: String = "https://github.com/LackyUA",
        systemActions: SystemActionsSpy = SystemActionsSpy()
    ) -> ContactsViewModel {
        ContactsViewModel(
            contacts: Contacts(
                title: "Contacts",
                description: "",
                address: "Ivano-Frankivsk, Ukraine",
                email: "name@example.com",
                mobile: mobile,
                git: git,
                linkedin: "https://www.linkedin.com/in/d-dobrovolskyi/"
            ),
            systemActions: systemActions
        )
    }

    private static func loadedConfiguration(of viewModel: ContactsViewModel) throws -> ContactsLoadedViewConfiguration {
        viewModel.initiate()
        guard case .loaded(let currentState) = viewModel.state else {
            throw LoadError()
        }
        return currentState.configuration
    }

    private static func row(
        _ title: String, in configuration: ContactsLoadedViewConfiguration
    ) throws -> ContactsLoadedViewConfiguration.Row {
        try #require(configuration.sections.flatMap(\.rows).first { $0.row.title == title })
    }

    // MARK: - LoadError

    private struct LoadError: Error {}
}
