//
//  ContactCell.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/26/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var actionImage: UIImageView!
    
    // MARK: - Configure cell
    func configure(title: String, details: String, image: UIImage?) {
        titleLabel.text = title
        detailsLabel.text = details
        
        if image != nil {
            actionImage.image = image!
        }
    }
    
    // MARK: - Open url
    func open(url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    // MARK: - Make a call
    func call(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            print("Unable to call.")
        }
    }
    
}
