//
//  EducationViewModel.swift
//  MyCV
//

import Foundation
import Observation

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

    var selectedPage: Page = .school

    private(set) var title = ""
    private(set) var school = ""
    private(set) var universityDetails: [UniversityDetail] = []
    private(set) var courses: [Course] = []

    private let service: APIServiceProtocol

    /// Display order for the university dictionary; unknown keys are appended alphabetically.
    private static let universityKeyOrder = ["University", "Direction", "Qualification", "GPA"]

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    func load() async {
        do {
            let education = try await service.fetch(Education.self)
            title = education.title
            school = education.school
            universityDetails = Self.orderedDetails(from: education.university)
            courses = education.courses.enumerated().map { index, name in
                Course(id: index, number: index + 1, name: name)
            }
        } catch {
            print(error)
        }
    }

    private static func orderedDetails(from university: [String: String]) -> [UniversityDetail] {
        let known = universityKeyOrder.compactMap { key in
            university[key].map { UniversityDetail(id: key, title: key, value: $0) }
        }
        let other = university.keys
            .filter { !universityKeyOrder.contains($0) }
            .sorted()
            .map { UniversityDetail(id: $0, title: $0, value: university[$0] ?? "") }

        return known + other
    }

}
