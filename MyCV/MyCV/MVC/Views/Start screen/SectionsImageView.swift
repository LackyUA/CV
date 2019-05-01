//
//  SectionsImageView.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/25/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

protocol Scalable { }

extension Scalable where Self: UIView {
    
    func scale(x: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: x, y: y)
    }
    
}

class SectionsImageView: UIView, Scalable {
    
    // MARK: - Views
    var imageView: UIImageView {
        let view = UIImageView()
        
        view.frame.size = CGSize(width: self.frame.height, height: self.frame.height)
        view.center = self.center
        
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = self.frame.height / 20
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.masksToBounds = true
        
        view.image = #imageLiteral(resourceName: "profileImage")
        
        return view
    }
    
    // TODO: Fix bug with scaling line
    var lineView: UIView {
        let view = UIView()
        
        view.frame.size = CGSize(width: self.frame.width, height: self.frame.height / 20)
        view.center = self.center
        view.backgroundColor = .darkGray
        
        return view
    }
    
    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    // MARK: - Configuration
    private func configure() {
        add(subviews: lineView, imageView)
    }
    
    private func add(subviews: UIView...) {
        subviews.forEach { self.addSubview($0) }
    }
    
}
