//
//  ViewController.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/24/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var labelConstraint: NSLayoutConstraint!
    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet private weak var welcomeLabel: UILabel! {
        didSet {
            let string = "Welcome To\nMy CV"
            let attributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.strokeColor: #colorLiteral(red: 1, green: 0.686330829, blue: 0.1061376974, alpha: 1),
                NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 24) ?? UIFont.boldSystemFont(ofSize: 24),
            ]
            
            welcomeLabel.attributedText = NSAttributedString(string: string, attributes: attributes)
        }
    }
    
    @IBOutlet private weak var startView: UIView! {
        didSet {
            startView.layer.cornerRadius = startView.frame.height / 2
            startView.layer.masksToBounds = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animate(on:)))
            startView.addGestureRecognizer(tapGesture)
        }
    }
    
    // MARK: - Life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Views configuration
    private func configure() {
        configureConstraint()
    }
    
    private func configureConstraint() {
        print(view.center.y / 4 - welcomeLabel.bounds.height / 2)
        labelConstraint.constant = view.center.y / 4 - welcomeLabel.bounds.height / 2
    }
    
    // MARK: - Animation
    @objc private func animate(on gesture: UIGestureRecognizer) {
        if let tapGesture = gesture as? UITapGestureRecognizer {
            switch tapGesture.state {
                
            case .changed:
                fallthrough
                
            case .ended:
                UIView.animate(withDuration: 0.5, animations: { [weak self] in
                    
                    self?.startView.transform = CGAffineTransform(scaleX: 4, y: 4)
                    self?.startLabel.alpha = 0
                    self?.welcomeLabel.transform = CGAffineTransform(translationX: 0, y: -(self?.view.frame.height ?? 1000))
                    
                }) { [weak self] _ in
                    
                    self?.view.backgroundColor = #colorLiteral(red: 0.09048522819, green: 0.7226287412, blue: 0.9303202025, alpha: 1)
                    self?.remove(views: self?.startView, self?.startLabel, self?.welcomeLabel)
                    
                }
                
            default:
                break
                
            }
        }
    }
    
    private func remove(views: UIView?...) {
        for case let view? in views {
            view.removeFromSuperview()
        }
    }

}

