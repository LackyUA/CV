//
//  Skills.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/25/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

struct Skills: JSONable {
    
    // MARK: - Coding keys
    enum CodingKeys: String, CodingKey {
        case skills
        case title
        case languages
        case embeddedFrameworks = "embedded_frameworks"
        case thirdPartyFrameworks = "third_party_frameworks"
        case designPatterns = "design_patterns"
        case operationSystems = "operation_systems"
    }
    
    // MARK: - Enum for decoding different values of dictionary(almost same as Any)
    private enum DictionaryValues: Decodable {
        case string(String)
        case array([String])
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            
            if let value = try? container.decode(String.self) {
                self = .string(value)
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
                
            case . array(let array):
                return array
                
            }
        }
    }
    
    // MARK: - Properties
    var title = String()
    var languages = [String]()
    var embeddedFrameworks = [String]()
    var thirdPartyFrameworks = [String]()
    var designPatterns = [String]()
    var operationSystems = [String]()
    
    // MARK: - JSON parser
    func parseJSON(completion: @escaping (Result<Skills, Error>) -> ()) {
        APIService().fetchData(struct: self) { result in
            completion(result)
        }
    }
    
}

// MARK: - Encodable protocol
extension Skills: Encodable {
    func encode(to encoder: Encoder) throws { }
}

// MARK: - Decodable protocol
extension Skills: Decodable {
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        let dict = try value.decode([String: DictionaryValues].self, forKey: .skills)
        
        self.title = dict[CodingKeys.title.rawValue]?.getValue() as? String ?? ""
        self.languages = dict[CodingKeys.languages.rawValue]?.getValue() as? [String] ?? []
        self.embeddedFrameworks = dict[CodingKeys.embeddedFrameworks.rawValue]?.getValue() as? [String] ?? []
        self.thirdPartyFrameworks = dict[CodingKeys.thirdPartyFrameworks.rawValue]?.getValue() as? [String] ?? []
        self.designPatterns = dict[CodingKeys.designPatterns.rawValue]?.getValue() as? [String] ?? []
        self.operationSystems = dict[CodingKeys.operationSystems.rawValue]?.getValue() as? [String] ?? []
    }
    
}
