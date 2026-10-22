//
//  Education.swift
//  Services
//

/// The school, university, and courses of the CV.
public struct Education: Decodable, Hashable, Sendable {

    /// The university degree.
    public struct University: Decodable, Hashable, Sendable {

        /// Creates a university degree.
        public init(name: String, direction: String, qualification: String, years: String, gpa: String) {
            self.name = name
            self.direction = direction
            self.qualification = qualification
            self.years = years
            self.gpa = gpa
        }

        /// The name of the university.
        public let name: String

        /// The field of study, such as `Computer Engineering`.
        public let direction: String

        /// The degree, such as `Master's Degree`.
        public let qualification: String

        /// The years of study, such as `2012–2019`.
        public let years: String

        /// The grade point average.
        public let gpa: String
    }

    /// Creates the education details.
    public init(title: String, school: String, university: University, courses: [String]) {
        self.title = title
        self.school = school
        self.university = university
        self.courses = courses
    }

    /// The title of the section, as the screen shows it.
    public let title: String

    /// The name of the school.
    public let school: String

    /// The university degree.
    public let university: University

    /// The completed courses, in CV order.
    public let courses: [String]
}
