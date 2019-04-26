//
//  Contacts.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/25/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

protocol JSONable where Self: Codable {
    func parseJSON(completion: @escaping (Result<Self, Error>) -> ())
}

struct Contacts: JSONable {
    
    // MARK: - Coding keys
    enum CodingKeys: String, CodingKey {
        case contacts
        case title
        case address
        case email
        case mobile
        case skype
        case git
        case facebook
    }
    
    // MARK: - Properties
    var title = String()
    var address = String()
    var email = String()
    var mobile = String()
    var skype = String()
    var git = String()
    var facebook = String()
    
    // MARK: - Initialization from JSON
    func parseJSON(completion: @escaping (Result<Contacts, Error>) -> ()) {
        APIService().fetchData(struct: self) { result in
            completion(result)
        }
    }
    
}

// MARK: - Encodable protocol
extension Contacts: Encodable {
    func encode(to encoder: Encoder) throws { }
}

// MARK: - Decodable protocol
extension Contacts: Decodable {
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        let dict = try value.decode([String: String].self, forKey: .contacts)
        
        self.title = dict[CodingKeys.title.rawValue] ?? ""
        self.address = dict[CodingKeys.address.rawValue] ?? ""
        self.email = dict[CodingKeys.email.rawValue] ?? ""
        self.mobile = dict[CodingKeys.mobile.rawValue] ?? ""
        self.skype = dict[CodingKeys.skype.rawValue] ?? ""
        self.git = dict[CodingKeys.git.rawValue] ?? ""
        self.facebook = dict[CodingKeys.facebook.rawValue] ?? ""
    }
    
}
