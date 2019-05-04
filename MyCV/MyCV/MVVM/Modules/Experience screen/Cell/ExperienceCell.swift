//
//  ExperienceCell.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/4/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class ExperienceCell: UITableViewCell, Configurable {
    
    // MARK: - Configuration
    func configure(viewModel: ExperienceCellViewModel) {
        textLabel?.text =  viewModel.title
    }
    
}
