//
//  DefaultService.swift
//  Services
//

import Foundation

/// Loads the CV content from the `Content.json` resource of the package.
final actor DefaultService: APIService {

    public func fetchContent() async throws -> Content {
        guard let url = Bundle.module.url(forResource: Constants.resourceName, withExtension: Constants.resourceExtension) else {
            throw APIServiceError.contentNotFound
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Content.self, from: data)
    }

    // MARK: - Constants

    private enum Constants {

        /// The name of the bundled content resource.
        static let resourceName = "Content"

        /// The file extension of the bundled content resource.
        static let resourceExtension = "json"
    }
}
