//
//  StackViewWithLabels.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/24/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class StackViewWithLabels: UIStackView {
    
    // MARK: - Views
    private var nameLabel: UILabel {
        return initLabel(with: "Dmytro")
    }
    
    private var surnameLabel: UILabel {
        return initLabel(with: "Dobrovolskyy")
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    // MARK: - Configuration
    private func configure() {
        configureStackView()
        add(labels: nameLabel, surnameLabel)
    }
    
    private func configureStackView() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillEqually
    }
    
    private func add(labels: UILabel...) {
        labels.forEach { self.addArrangedSubview($0) }
    }
    
    // MARK: - Helpers
    private func initLabel(with text: String) -> UILabel {
        let label = UILabel()
        
        label.textAlignment = .center
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .darkGray
        
        return label
    }
    
}
