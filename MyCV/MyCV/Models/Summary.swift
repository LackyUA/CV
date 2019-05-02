//
//  Summary.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/25/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

struct Summary: JSONable {
    
    // MARK: - Coding keys
    enum CodingKeys: String, CodingKey {
        case summary = "objective_and_summary"
        case title
        case description
    }
    
    // MARK: - Properties
    var title = String()
    var description = String()
    
    // MARK: - JSON parser
    func parseJSON(completion: @escaping (Result<Summary, Error>) -> ()) {
        APIService().fetchData(struct: self) { result in
            completion(result)
        }
    }
    
}

// MARK: - Encodable protocol
extension Summary: Encodable {
    func encode(to encoder: Encoder) throws { }
}

// MARK: - Decodable protocol
extension Summary: Decodable {
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        let dict = try value.decode([String: String].self, forKey: .summary)
        
        self.title = dict[CodingKeys.title.rawValue] ?? ""
        self.description = dict[CodingKeys.description.rawValue] ?? ""
    }
    
}
