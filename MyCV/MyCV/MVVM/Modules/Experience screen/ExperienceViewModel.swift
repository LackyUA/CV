//
//  ExperienceViewModel.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/4/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

class ExperienceViewModel {
    
    let title = Observable<String>(value: "")
    let experienceCellViewModels = Observable<[ExperienceCellViewModel]>(value: [])
    
}
