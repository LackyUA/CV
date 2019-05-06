//
//  Extensions.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/1/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Generating constraints to superview's edge
    func edgeConstraints(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> [NSLayoutConstraint] {
        return [
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: self.superview!.rightAnchor, constant: -right),
            self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: -bottom)
        ]
    }
    
}

extension UITableViewCell {
    
    /// Generated cell identifier derived from class name
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
    
}

extension UINavigationController {
    
    override open var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
}
