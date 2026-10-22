//
//  EducationViewModel.swift
//  MyCV
//

import Foundation
import Observation
import Services

@MainActor
@Observable
final class EducationViewModel {

    /// The three pages of the education screen, in display order.
    enum Page: Int, CaseIterable, Identifiable {
        case school
        case university
        case courses

        var id: Self { self }

        var title: LocalizedStringResource {
            switch self {
            case .school: "School"
            case .university: "University"
            case .courses: "Courses"
            }
        }
    }

    struct UniversityDetail: Identifiable, Equatable {
        let id: String
        let title: String
        let value: String
    }

    struct Course: Identifiable, Equatable {
        let id: Int
        let number: Int
        let name: String
    }

    init(education: Education) {
        title = education.title
        school = education.school
        universityDetails = Self.makeDetails(from: education.university)
        courses = education.courses.enumerated().map { index, name in
            Course(id: index, number: index + 1, name: name)
        }
    }

    let title: String
    let school: String
    let universityDetails: [UniversityDetail]
    let courses: [Course]

    var selectedPage: Page = .school

    // MARK: - Private Methods

    /// One labelled row per university field, in display order. Empty fields are skipped.
    private static func makeDetails(from university: Education.University) -> [UniversityDetail] {
        [
            UniversityDetail(id: "name", title: "University", value: university.name),
            UniversityDetail(id: "direction", title: "Direction", value: university.direction),
            UniversityDetail(id: "qualification", title: "Qualification", value: university.qualification),
            UniversityDetail(id: "years", title: "Years", value: university.years),
            UniversityDetail(id: "gpa", title: "GPA", value: university.gpa)
        ]
        .filter { !$0.value.isEmpty }
    }

}
