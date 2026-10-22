//
//  Version.swift
//  Core
//
//  Created by Andrii Vysotskyi on 03.06.2025.
//

/// A structure representing a semantic version, composed of major, minor, and patch components.
public struct Version: Sendable, Hashable, Codable {

    public init(major: Int, minor: Int = 0, patch: Int = 0) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }

    /// The major version number.
    public let major: Int

    /// The minor version number.
    public let minor: Int

    /// The patch version number.
    public let patch: Int
}

extension Version: Comparable {

    public static func < (lhs: Version, rhs: Version) -> Bool {
        if lhs.major != rhs.major {
            return lhs.major < rhs.major
        }
        if lhs.minor != rhs.minor {
            return lhs.minor < rhs.minor
        }
        return lhs.patch < rhs.patch
    }
}
