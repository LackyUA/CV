//
//  SectionsView.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/24/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

protocol Moveable { }

extension Moveable where Self: UIView {
    
    func move(translationX x: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(translationX: x, y: y )
    }
    
}

class SectionsView: UIView, Moveable {
    
    // MARK: - Properties
    var bottomPadding: CGFloat {
        if #available(iOS 11.0, *) {
            guard let padding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom else { return 0 }
            
            return padding
        }
        
        return 0
    }
    
    // MARK: - Views
    private var labelsStackView: StackViewWithLabels {
        let stackView = StackViewWithLabels(frame: CGRect(x: 0, y: 70, width: frame.width, height: 70))
        
        return stackView
    }
    
    private var buttonsStackView: StackViewWithButtons {
        let stackView = StackViewWithButtons(frame: CGRect(
            x: 15,
            y: labelsStackView.frame.maxY + 10,
            width: frame.width - 30,
            height: frame.height - labelsStackView.frame.maxY - 10 - bottomPadding - 10
        ))
        
        return stackView
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    // MARK: - Configuration
    private func configure() {
        add(subviews: labelsStackView, buttonsStackView)
    }
    
    private func add(subviews: UIView...) {
        subviews.forEach { self.addSubview($0) }
    }
    
}
