//
//  Date+ParseStrategy.swift
//  Core
//
//  Created by Serhii Yelmanov on 15.09.2025.
//

import Foundation

extension Date {

    /// Creates a `Date` from a Kyiv-timezone date string (yyyy-MM-dd), anchored to noon to ensure
    /// correct calendar-day display across all client timezones.
    public init(kyivDateString value: String) throws {
        // Anchor date to business time zone (Kyiv)
        guard let kyivTimeZone = TimeZone(identifier: "Europe/Kyiv") else {
            preconditionFailure("Time zone must be available.")
        }
        let parseStrategy = Date.ParseStrategy(
            format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits)",
            timeZone: kyivTimeZone
        )
        // Hardcode noon to avoid issues in nearby time zones
        self = try Date(value, strategy: parseStrategy).addingTimeInterval(12 * 60 * 60)
    }
}
