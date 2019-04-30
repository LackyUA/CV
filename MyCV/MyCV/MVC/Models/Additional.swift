//
//  Additional.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/25/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

struct Additional: JSONable {
    
    // MARK: - Coding keys
    enum CodingKeys: String, CodingKey {
        case additional = "additional_information"
        case title
        case hobbies
        case english
        case maritalStatus = "marital_status"
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
    var hobbies = [String]()
    var english = String()
    var maritalStatus = String()
    
    // MARK: - JSON parser
    func parseJSON(completion: @escaping (Result<Additional, Error>) -> ()) {
        APIService().fetchData(struct: self) { result in
            completion(result)
        }
    }
    
}

// MARK: - Encodable protocol
extension Additional: Encodable {
    func encode(to encoder: Encoder) throws { }
}

// MARK: - Decodable protocol
extension Additional: Decodable {
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        let dict = try value.decode([String: DictionaryValues].self, forKey: .additional)
        
        self.title = dict[CodingKeys.title.rawValue]?.getValue() as? String ?? ""
        self.hobbies = dict[CodingKeys.hobbies.rawValue]?.getValue() as? [String] ?? []
        self.english = dict[CodingKeys.english.rawValue]?.getValue() as? String ?? ""
        self.maritalStatus = dict[CodingKeys.maritalStatus.rawValue]?.getValue() as? String ?? ""
    }
    
}
