//
//  Summary.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/25/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

final class Summary: JSONable {
    
    // MARK: - Coding keys
    enum CodingKeys: String, CodingKey {
        case summary = "objective_and_summary"
        case title
        case description
    }
    
    // MARK: - Properties
    var title = String()
    var description = String()
    
    init() {
        initFromJSON()
    }
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
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
    
    private func initData(_ data: Summary) {
        self.title = data.title
        self.description = data.description
    }
    
}

// MARK: - Encodable protocol
extension Summary: Encodable {
    func encode(to encoder: Encoder) throws { }
}

// MARK: - Decodable protocol
extension Summary: Decodable {
    
    convenience init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        let dict = try value.decode([String: String].self, forKey: .summary)
        
        self.init(
            title: dict[CodingKeys.title.rawValue] ?? "",
            description: dict[CodingKeys.description.rawValue] ?? ""
        )
    }
    
}
