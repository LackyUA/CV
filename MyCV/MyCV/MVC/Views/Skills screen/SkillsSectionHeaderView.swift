//
//  SkillsSectionHeaderView.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/1/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class SkillsSectionHeaderView: UIView {
    
    // MARK: - Header views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        label.font = UIFont(name: "GillSans-Italic", size: 20.0)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var separators: [UIView] = {
        var views = [UIView]()
        
        for index in 0...1 {
            views.append(addSeparator(withTag: index))
        }
        
        return views
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        
        configure()
    }
    
    // MARK: - Configuration
    private func configure() {
        self.backgroundColor = #colorLiteral(red: 0.09048522819, green: 0.7226287412, blue: 0.9303202025, alpha: 1)
        confiureConstraints()
    }
    
    // MARK: - Function for creating separator
    private func addSeparator(withTag tag: Int) -> UIView {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        view.backgroundColor = UIColor.lightGray
        view.tag = tag
        
        return view
    }
    
    // MARK: - Customization functions
    func setTitle(with text: String) {
        self.titleLabel.text = text
    }
    
    // MARK: - Constraints configuration
    private func confiureConstraints() {
        NSLayoutConstraint.activate(titleLabel.edgeConstraints(top: 5, left: 15, bottom: 5, right: 15))
        
        for separator in separators {
            configureSeparatorConstraints(separator)
        }
    }
    
    private func configureSeparatorConstraints(_ separator: UIView) {
        switch separator.tag {
        
        case 0:
            NSLayoutConstraint.activate([
                separator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
                separator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
                separator.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
                separator.heightAnchor.constraint(equalToConstant: 0.4)
                ])
            
        case 1:
            NSLayoutConstraint.activate([
                separator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
                separator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
                separator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
                separator.heightAnchor.constraint(equalToConstant: 0.4)
                ])
            
        default:
            break
            
        }
    }
    
}
