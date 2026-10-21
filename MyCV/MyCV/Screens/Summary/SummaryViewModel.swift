//
//  SummaryViewModel.swift
//  MyCV
//

import Foundation
import Observation

@MainActor
@Observable
final class SummaryViewModel {

    /// A single sentence of the summary, rendered as its own paragraph.
    struct Paragraph: Identifiable, Equatable {
        let id: Int
        let text: String
    }

    private(set) var title = ""
    private(set) var paragraphs: [Paragraph] = []

    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    func load() async {
        do {
            let summary = try await service.fetch(Summary.self)
            title = summary.title
            paragraphs = Self.makeParagraphs(from: summary.description)
        } catch {
            print(error)
        }
    }

    /// Splits the description into sentences so each one can be shown as a separate paragraph.
    private static func makeParagraphs(from description: String) -> [Paragraph] {
        description
            .split(separator: ".")
            .enumerated()
            .map { index, sentence in
                Paragraph(id: index, text: sentence.trimmingCharacters(in: .whitespacesAndNewlines) + ".")
            }
    }

}
