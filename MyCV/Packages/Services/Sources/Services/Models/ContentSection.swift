//
//  ContentSection.swift
//  Services
//

/// One section of the CV with its data.
///
/// The `type` field of a JSON entry selects the case. The other fields of the entry are the data of the case.
public enum ContentSection: Decodable, Hashable, Sendable {

    /// The contact details, such as the e-mail address and the profile links.
    case contacts(Contacts)

    /// The profile text and the engineering highlights.
    case summary(Summary)

    /// The skills, grouped into titled sections.
    case skills(Skills)

    /// The school, the university degree, and the courses.
    case education(Education)

    /// The job positions, from the most recent to the oldest.
    case experience(Experience)

    /// The hobbies, the languages, and the community membership.
    case additional(Additional)

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(Kind.self, forKey: .type) {
        case .contacts:
            self = .contacts(try Contacts(from: decoder))
        case .summary:
            self = .summary(try Summary(from: decoder))
        case .skills:
            self = .skills(try Skills(from: decoder))
        case .education:
            self = .education(try Education(from: decoder))
        case .experience:
            self = .experience(try Experience(from: decoder))
        case .additional:
            self = .additional(try Additional(from: decoder))
        }
    }

    /// The title of the section, as the start screen and the section screen show it.
    public var title: String {
        switch self {
        case .contacts(let contacts):
            contacts.title
        case .summary(let summary):
            summary.title
        case .skills(let skills):
            skills.title
        case .education(let education):
            education.title
        case .experience(let experience):
            experience.title
        case .additional(let additional):
            additional.title
        }
    }

    // MARK: - Private Types

    private enum CodingKeys: String, CodingKey {
        case type
    }

    /// The values of the `type` field.
    private enum Kind: String, Decodable {
        case contacts
        case summary
        case skills
        case education
        case experience
        case additional
    }
}
