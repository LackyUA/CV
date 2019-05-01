//
//  SkillCell.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/1/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class SkillCell: UITableViewCell {
    
    func configure(text: String) {
        self.isUserInteractionEnabled = false
        self.textLabel?.text = text
    }
    
}
