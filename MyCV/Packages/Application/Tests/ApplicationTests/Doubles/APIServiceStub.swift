//
//  APIServiceStub.swift
//  ApplicationTests
//

import Services

/// Returns a fixed result for every content request.
struct APIServiceStub: APIService {

    /// The error that the stub throws when it fails.
    struct Failure: Error {}

    /// The content to return, or `nil` to throw `Failure`.
    let content: Content?

    func fetchContent() async throws -> Content {
        guard let content else {
            throw Failure()
        }
        return content
    }
}
