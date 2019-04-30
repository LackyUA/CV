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
        case operationSystems = "operation_systems"
    }
    
    // MARK: - Properties
    var title = String()
    var languages = String()
    var embeddedFrameworks = String()
    var thirdPartyFrameworks = String()
    var operationSystems = String()
    
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
        let dict = try value.decode([String: String].self, forKey: .skills)
        
        self.title = dict[CodingKeys.title.rawValue] ?? ""
        self.languages = dict[CodingKeys.languages.rawValue] ?? ""
        self.embeddedFrameworks = dict[CodingKeys.embeddedFrameworks.rawValue] ?? ""
        self.thirdPartyFrameworks = dict[CodingKeys.thirdPartyFrameworks.rawValue] ?? ""
        self.operationSystems = dict[CodingKeys.operationSystems.rawValue] ?? ""
    }
    
}
