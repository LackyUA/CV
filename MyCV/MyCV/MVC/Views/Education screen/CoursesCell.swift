//
//  CoursesCell.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/2/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class CoursesCell: UICollectionViewCell {
    
    @IBOutlet private var courseLabels: [UILabel]!
    
    func configure(_ array: [String]) {
        for (index, value) in array.enumerated() {
            courseLabels[index].text = "\(index + 1). \(value)"
        }
    }
    
}
