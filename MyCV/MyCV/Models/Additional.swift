//
//  Additional.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/25/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

final class Additional: JSONable {
    
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
    
    // MARK: - Initializations
    init () {
        initFromJSON()
    }
    
    init(title: String, hobbies: [String], english: String, maritalStatus: String) {
        self.title = title
        self.hobbies = hobbies
        self.english = english
        self.maritalStatus = maritalStatus
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
    
    private func initData(_ data: Additional) {
        self.title = data.title
        self.hobbies = data.hobbies
        self.english = data.english
        self.maritalStatus = data.maritalStatus
    }
    
}

// MARK: - Encodable protocol
extension Additional: Encodable {
    func encode(to encoder: Encoder) throws { }
}

// MARK: - Decodable protocol
extension Additional: Decodable {
    
    convenience init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        let dict = try value.decode([String: DictionaryValues].self, forKey: .additional)
        
        self.init(
            title: dict[CodingKeys.title.rawValue]?.getValue() as? String ?? "",
            hobbies: dict[CodingKeys.hobbies.rawValue]?.getValue() as? [String] ?? [],
            english: dict[CodingKeys.english.rawValue]?.getValue() as? String ?? "",
            maritalStatus: dict[CodingKeys.maritalStatus.rawValue]?.getValue() as? String ?? ""
        )
    }
    
}
