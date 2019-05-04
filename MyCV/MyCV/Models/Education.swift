//
//  Education.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/25/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

final class Education: JSONable {
    
    // MARK: - Coding keys
    private enum CodingKeys: String, CodingKey {
        case education
        case title
        case school
        case university
        case courses
    }
    
    // MARK: - Enum for decoding different values of dictionary(almost same as Any)
    private enum DictionaryValues: Decodable {
        case string(String)
        case dictionary([String: String])
        case array([String])
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            
            if let value = try? container.decode(String.self) {
                self = .string(value)
            } else if let value = try? container.decode([String: String].self) {
                self = .dictionary(value)
            } else if let value = try? container.decode([String].self) {
                self = .array(value)
            } else {
                let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "Unknown type")
                throw DecodingError.dataCorrupted(context)
            }
        }
        
        func getValue() -> Any {
            switch self {
                
            case .string(let string):
                return string
                
            case .dictionary(let dictionary):
                return dictionary
                
            case . array(let array):
                return array
                
            }
        }
    }
    
    // MARK: - Properties
    var title = String()
    var school = String()
    var university = [String: String]()
    var courses = [String]()
    
    // MARK: - Initializations
    init () {
        initFromJSON()
    }
    
    init(title: String, school: String, university: [String: String], courses: [String]) {
        self.title = title
        self.school = school
        self.university = university
        self.courses = courses
    }
    
    // MARK: - JSON parser
    func initFromJSON() {
        APIService().fetchData(class: self) { result in
            switch result {
                
            case .success(let data):
                self.initData(data)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    private func initData(_ data: Education) {
        self.title = data.title
        self.school = data.school
        self.university = data.university
        self.courses = data.courses
    }
    
}

// MARK: - Encodable protocol
extension Education: Encodable {
    func encode(to encoder: Encoder) throws { }
}

// MARK: - Decodable protocol
extension Education: Decodable {
    
    convenience init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        let dict = try value.decode([String: DictionaryValues].self, forKey: .education)
        
        self.init(
            title: dict[CodingKeys.title.rawValue]?.getValue() as? String ?? "",
            school: dict[CodingKeys.school.rawValue]?.getValue() as? String ?? "",
            university: dict[CodingKeys.university.rawValue]?.getValue() as? [String: String] ?? [:],
            courses: dict[CodingKeys.courses.rawValue]?.getValue() as? [String] ?? []
        )
    }
    
}
