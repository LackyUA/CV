//
//  AdditionalViewModel.swift
//  MyCV
//

import Foundation
import Observation

@MainActor
@Observable
final class AdditionalViewModel {

    struct Entry: Identifiable, Equatable {
        let id: String
        let title: LocalizedStringResource
        let value: String
    }

    private(set) var title = ""
    private(set) var entries: [Entry] = []

    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    func load() async {
        do {
            let additional = try await service.fetch(Additional.self)
            title = additional.title
            entries = [
                Entry(id: "hobbies", title: "Hobbies", value: Self.hobbiesText(additional.hobbies)),
                Entry(id: "english", title: "English", value: additional.english + "."),
                Entry(id: "maritalStatus", title: "Marital status", value: additional.maritalStatus + ".")
            ]
        } catch {
            print(error)
        }
    }

    /// One hobby per line, separated by semicolons and closed with a period.
    private static func hobbiesText(_ hobbies: [String]) -> String {
        guard !hobbies.isEmpty else { return "" }
        return hobbies.joined(separator: ";\n") + "."
    }

}
