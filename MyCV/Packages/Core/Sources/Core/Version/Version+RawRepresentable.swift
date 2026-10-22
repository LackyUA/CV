//
//  Version+RawRepresentable.swift
//  Core
//
//  Created by Andrii Vysotskyi on 03.06.2025.
//

extension Version: RawRepresentable {

    public init?(rawValue: String) {
        do {
            let parser = VersionParser()
            self = try parser.parse(version: rawValue)
        } catch {
            return nil
        }
    }

    public var rawValue: String {
        [major, minor, patch].map(\.description).joined(separator: ".")
    }
}
