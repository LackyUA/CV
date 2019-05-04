//
//  ExperienceController.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/4/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

class ExperienceController {
    
    // MARK: - Constants
    let dataKeys = [
        "name",
        "period",
        "link",
        "description"
    ]
    let viewModel: ExperienceViewModel
    let model: Experience
    
    // MARK: - Initialization
    init(viewModel: ExperienceViewModel = ExperienceViewModel(), model: Experience = Experience()) {
        self.viewModel = viewModel
        self.model = model
    }
    
    // MARK: - Function for getting data from Json and saving it to models
    func start() {
        model.fetchDataFromJSON { (model) in
            self.viewModel.title.value = model.title
            self.buildViewModels(data: model.iosDeveloping)
        }
    }
    
    func buildViewModels(data: [[String: String]]) {
        for value in data {
            let experienceCellViewModel = ExperienceCellViewModel(
                title: value[dataKeys[0]] ?? "",
                period: value[dataKeys[1]] ?? "",
                link: value[dataKeys[2]] ?? "",
                description: value[dataKeys[3]] ?? ""
            )
            
            viewModel.experienceCellViewModels.value.append(experienceCellViewModel)
        }
    }
    
}
