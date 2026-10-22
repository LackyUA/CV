//
//  AdditionalViewModel.swift
//  MyCV
//

import Foundation
import Observation
import Services

@MainActor
@Observable
final class AdditionalViewModel {

    struct Entry: Identifiable, Equatable {
        let id: String
        let title: LocalizedStringResource
        let value: String
    }

    init(service: APIService) {
        self.service = service
    }

    private(set) var title = ""
    private(set) var entries: [Entry] = []

    func load() async {
        do {
            let additional = try await service.fetchContent().additional
            title = additional.title
            entries = [
                Entry(id: "hobbies", title: "Hobbies", value: Self.hobbiesText(additional.hobbies)),
                Entry(id: "english", title: "English", value: additional.english + "."),
                Entry(id: "ukrainian", title: "Ukrainian", value: additional.ukrainian + "."),
                Entry(id: "community", title: "Community", value: additional.community + ".")
            ]
        } catch {
            print(error)
        }
    }

    // MARK: - Private Properties

    private let service: APIService

    // MARK: - Private Methods

    /// One hobby per line, separated by semicolons and closed with a period.
    private static func hobbiesText(_ hobbies: [String]) -> String {
        guard !hobbies.isEmpty else { return "" }
        return hobbies.joined(separator: ";\n") + "."
    }

}
