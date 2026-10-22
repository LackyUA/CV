//
//  ExperienceItem.swift
//  MyCV
//

import Foundation

/// A single project from the experience list. Also used as the navigation value for the details screen.
struct ExperienceItem: Identifiable, Hashable {
    let id: Int
    let title: String
    let period: String
    let link: String
    let description: String
}
