//
//  VersionParser.swift
//  Core
//
//  Created by Andrii Vysotskyi on 03.06.2025.
//

import Foundation
import RegexBuilder

/// A parser responsible for parsing semantic version strings (e.g., "1.2.3").
struct VersionParser: Sendable {

    /// Parses a version string into a `Version` instance.
    func parse(version: String) throws(VersionParserError) -> Version {
        let versionCoreRegex = self.versionCoreRegex.regex
        do {
            guard let match = try versionCoreRegex.regex.wholeMatch(in: version) else {
                throw VersionParserError(code: .unsupportedFormat, underlyingError: nil)
            }
            guard let major = match.output.1, let minor = match.output.2, let patch = match.output.3 else {
                throw VersionParserError(code: .invalidComponent, underlyingError: nil)
            }
            return .init(major: major, minor: minor, patch: patch)
        } catch {
            throw VersionParserError(code: .unsupportedFormat, underlyingError: error)
        }
    }

    // MARK: - Private Methods

    // swiftlint:disable:next large_tuple
    private var versionCoreRegex: some RegexComponent<(Substring, Int?, Int?, Int?)> {
        let numericIdentifierRegex = ChoiceOf {
            "0"
            Regex {
                ("1"..."9")
                ZeroOrMore(.digit)
            }
        }
        let versionCoreRegex = Regex {
            Capture(numericIdentifierRegex) { value in
                Int(value)
            }
            "."
            Capture(numericIdentifierRegex) { value in
                Int(value)
            }
            "."
            Capture(numericIdentifierRegex) { value in
                Int(value)
            }
        }
        return versionCoreRegex
    }
}
