//
//  Bundle+Version.swift
//  Core
//
//  Created by Andrii Vysotskyi on 03.06.2025.
//

import Foundation

extension Bundle {

    /// The app's short version string (e.g., "1.2.3"), parsed into a `Version` object.
    public var bundleShortVersion: Version {
        guard let bundleShortVersionString = infoDictionary?["CFBundleShortVersionString"] as? String else {
            preconditionFailure("Version is not available.")
        }
        guard let version = Version(rawValue: bundleShortVersionString) else {
            preconditionFailure("Version is invalid.")
        }
        return version
    }
}
