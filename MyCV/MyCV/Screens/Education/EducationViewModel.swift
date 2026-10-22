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

    init(service: APIService) {
        self.service = service
    }

    var selectedPage: Page = .school

    private(set) var title = ""
    private(set) var school = ""
    private(set) var universityDetails: [UniversityDetail] = []
    private(set) var courses: [Course] = []

    func load() async {
        do {
            let education = try await service.fetchContent().education
            title = education.title
            school = education.school
            universityDetails = Self.makeDetails(from: education.university)
            courses = education.courses.enumerated().map { index, name in
                Course(id: index, number: index + 1, name: name)
            }
        } catch {
            print(error)
        }
    }

    // MARK: - Private Properties

    private let service: APIService

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
