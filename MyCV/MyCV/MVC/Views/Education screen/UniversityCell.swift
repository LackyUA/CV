//
//  UniversityCell.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/2/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class UniversityCell: UICollectionViewCell {
    
    @IBOutlet private var titles: [UILabel]!
    @IBOutlet private var descriptions: [UILabel]!
    
    func configure(_ data: [String: String]) {
        for (index, element) in data.enumerated() {
            titles[index].text = element.key
            descriptions[index].text = element.value
        }
    }
    
}
