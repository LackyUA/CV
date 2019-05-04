//
//  ExperienceCellViewModel.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/4/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

class ExperienceCellViewModel {
    
    let title: String
    let period: String
    let link: String
    let description: String
    
    init(title: String = "", period: String = "", link: String = "", description: String = "") {
        self.title = title
        self.period = period
        self.link = link
        self.description = description
    }
    
}
