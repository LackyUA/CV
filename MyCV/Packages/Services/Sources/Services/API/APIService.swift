//
//  APIService.swift
//  Services
//

import Foundation

/// Loads the CV content.
public protocol APIService: Sendable {

    /// Loads and decodes the full CV content.
    func fetchContent() async throws -> Content
}
