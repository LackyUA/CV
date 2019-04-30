//
//  Experience.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/25/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

struct Experience: JSONable {
    
    // MARK: - Coding keys
    enum CodingKeys: String, CodingKey {
        case experience
        case title
        case iosDeveloping = "iOS_developing"
    }
    
    // MARK: - Enum for decoding different values of dictionary(almost same as Any)
    private enum DictionaryValues: Decodable {
        case string(String)
        case array([[String: String]])
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            
            if let value = try? container.decode(String.self) {
                self = .string(value)
            } else if let value = try? container.decode([[String: String]].self) {
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
    var iosDeveloping = [[String: String]]()
    
    // MARK: - JSON parser
    func parseJSON(completion: @escaping (Result<Experience, Error>) -> ()) {
        APIService().fetchData(struct: self) { result in
            completion(result)
        }
    }
    
}

// MARK: - Encodable protocol
extension Experience: Encodable {
    func encode(to encoder: Encoder) throws { }
}

// MARK: - Decodable protocol
extension Experience: Decodable {
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        let dict = try value.decode([String: DictionaryValues].self, forKey: .experience)
        
        self.title = dict[CodingKeys.title.rawValue]?.getValue() as? String ?? ""
        self.iosDeveloping = dict[CodingKeys.iosDeveloping.rawValue]?.getValue() as? [[String: String]] ?? []
    }
    
}
