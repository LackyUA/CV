//
//  CVSection.swift
//  MyCV
//

import Foundation

/// The sections of the CV reachable from the start screen.
enum CVSection: CaseIterable, Identifiable {
    case contacts
    case summary
    case skills
    case education
    case experience
    case additional

    var id: Self { self }

    /// Title shown on the start screen button for this section.
    var title: LocalizedStringResource {
        switch self {
        case .contacts: "Contacts"
        case .summary: "Objective & summary"
        case .skills: "Skills"
        case .education: "Education"
        case .experience: "Experience"
        case .additional: "Additional information"
        }
    }
}
