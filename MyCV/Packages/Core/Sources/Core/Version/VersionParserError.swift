//
//  VersionParserError.swift
//  Core
//
//  Created by Andrii Vysotskyi on 03.06.2025.
//

/// An error representing specific failures that can occur during version parsing.
public struct VersionParserError: Error {

    /// A code representing the type of parsing failure.
    public enum Code: Sendable {

        /// One or more components (major, minor, patch) is invalid.
        case invalidComponent

        /// The input contained unsupported semantic elements.
        case unsupportedFormat
    }

    /// The specific kind of parsing error.
    public let code: Code

    /// An optional underlying error that provides additional context.
    public let underlyingError: Error?
}
