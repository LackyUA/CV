//
//  Contacts.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/25/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

protocol JSONable where Self: Codable {
    func initFromJSON()
}

final class Contacts: JSONable {
    
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
    
    // MARK: - Initializations
    init () {
        initFromJSON()
    }
    
    init(title: String, address: String, email: String, mobile: String, skype: String, git: String, facebook: String) {
        self.title = title
        self.address = address
        self.email = email
        self.mobile = mobile
        self.skype = skype
        self.git = git
        self.facebook = facebook
    }
    
    // MARK: - JSON parser
    func initFromJSON() {
        APIService().fetchData(class: self) { result in
            switch result {
                
            case .success(let data):
                self.initData(data)
                
            case .failure(let err):
                print(err)
                
            }
        }
    }
    
    private func initData(_ data: Contacts) {
        title = data.title
        address = data.address
        email = data.email
        mobile = data.mobile
        skype = data.skype
        git = data.git
        facebook = data.facebook
    }
    
}

// MARK: - Encodable protocol
extension Contacts: Encodable {
    func encode(to encoder: Encoder) throws { }
}

// MARK: - Decodable protocol
extension Contacts: Decodable {
    
    convenience init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        let dict = try value.decode([String: String].self, forKey: .contacts)
        
        self.init(
            title: dict[CodingKeys.title.rawValue] ?? "",
            address: dict[CodingKeys.address.rawValue] ?? "",
            email: dict[CodingKeys.email.rawValue] ?? "",
            mobile: dict[CodingKeys.mobile.rawValue] ?? "",
            skype: dict[CodingKeys.skype.rawValue] ?? "",
            git: dict[CodingKeys.git.rawValue] ?? "",
            facebook: dict[CodingKeys.facebook.rawValue] ?? ""
        )
    }
    
}
