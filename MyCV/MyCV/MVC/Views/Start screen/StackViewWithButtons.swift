//
//  StackViewWithButtons.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/24/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class StackViewWithButtons: UIStackView {
    
    // MARK: - Constants
    private let content = [
        "Contacts",
        "Objective & summary",
        "Skills",
        "Education",
        "Experience",
        "Additional information"
    ]
    
    // MARK: - Views
    private var buttons: [UIButton] {
        var buttonsArray = [UIButton]()
        
        for tag in 0...5 {
            buttonsArray.append(initButton(withTitle: content[tag], tag: tag))
        }
        
        return buttonsArray
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
        add(buttons)
    }
    
    private func configureStackView() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 8.0
    }
    
    private func add(_ buttons: [UIButton]) {
        buttons.forEach { self.addArrangedSubview($0) }
    }
    
    // MARK: - Buttons init helper
    private func initButton(withTitle title: String, tag: Int) -> UIButton {
        let button = UIButton()
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.backgroundColor = #colorLiteral(red: 0.3411357999, green: 0.3411998153, blue: 0.341131717, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.tag = tag
        
        button.addTarget(self, action: #selector(addActionsForButtons(sender:)), for: .touchUpInside)
        
        button.layer.cornerRadius = 8.0
        button.layer.masksToBounds = true
        
        return button
    }
    
    @objc private func addActionsForButtons(sender: UIButton) {
        
        switch sender.tag {
            
        case 0:
            present(identifier: "Contacts")
            
        case 1:
            present(identifier: "Summary")
            
        case 2:
            present(identifier: "Skills")
            
        case 3:
            present(identifier: "Education")
            
        case 4:
            present(identifier: "Experience")
            
        case 5:
            present(identifier: "Additional")
            
        default:
            break
            
        }
    }
    
    @objc private func present(identifier: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let root = appDelegate.window?.rootViewController
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        
        root?.present(vc, animated: true, completion: nil)
    }
    
}
