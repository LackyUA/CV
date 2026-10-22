//
//  SummaryViewModel.swift
//  MyCV
//

import Foundation
import Observation
import Services

@MainActor
@Observable
final class SummaryViewModel {

    /// One block of the summary text, rendered as its own paragraph.
    struct Paragraph: Identifiable, Equatable {
        let id: Int
        let text: String
    }

    init(summary: Summary) {
        title = summary.title
        paragraphs = Self.makeParagraphs(description: summary.description, highlights: summary.highlights)
    }

    let title: String
    let paragraphs: [Paragraph]

    // MARK: - Private Methods

    /// The profile description first, then each highlight as a bullet paragraph.
    private static func makeParagraphs(description: String, highlights: [String]) -> [Paragraph] {
        let texts = [description] + highlights.map { Constants.bullet + $0 }
        return texts.enumerated().map { index, text in
            Paragraph(id: index, text: text)
        }
    }

    // MARK: - Constants

    private enum Constants {

        /// The prefix of a highlight paragraph.
        static let bullet = "• "
    }

}
