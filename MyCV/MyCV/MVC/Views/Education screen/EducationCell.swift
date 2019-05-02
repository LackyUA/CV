//
//  EducationCell.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/1/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class EducationCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(text: String) {
        titleLabel.text = text
    }
    
}
