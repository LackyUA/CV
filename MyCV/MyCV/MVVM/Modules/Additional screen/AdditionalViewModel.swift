//
//  AdditionalViewModel.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/4/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

class AdditionalViewModel {
    
    // MARK: - Constants
    private let model: Additional
    let dataKeys = [
        "Hobbies",
        "English",
        "Marital status"
    ]
    
    // MARK: - Initializitaion
    init(model: Additional) {
        self.model = model
    }
    
    // MARK: - Properties
    var title: String {
        return model.title
    }
    
    var data: [String: String] {
        var data = [String: String]()
        
        var hobbies = String()
        for (index, hobbie) in model.hobbies.enumerated() {
            if index < model.hobbies.count - 1 {
                hobbies += (hobbie + ";\n")
            } else {
                hobbies += (hobbie + ".")
            }
        }
        
        data[dataKeys[0]] = hobbies
        data[dataKeys[1]] = model.english + "."
        data[dataKeys[2]] = model.maritalStatus + "."
        
        return data
    }
    
}
