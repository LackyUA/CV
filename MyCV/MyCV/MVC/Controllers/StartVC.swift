//
//  StartVC.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/24/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class StartVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var labelConstraint: NSLayoutConstraint!
    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet private weak var welcomeLabel: UILabel! {
        didSet {
            let string = "Welcome To\nMy CV"
            let attributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.686330829, blue: 0.1061376974, alpha: 1),
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
                UIView.animate(withDuration: 0.5,
                               animations: { [weak self] in
                    
                    guard let self = self else { return }
                    
                    self.firstStep()
                    
                }) { [weak self] _ in
                    
                    guard let self = self else { return }
                    
                    self.secondStep()
                    
                    UIView.animate(withDuration: 0.7,
                                   delay: 0,
                                   usingSpringWithDamping: 0.95,
                                   initialSpringVelocity: 0.7,
                                   options: [.curveEaseInOut],
                                   animations: { [weak self] in
                        
                        guard let self = self else { return }
                        
                        self.thirdStep()
                        
                    })
                    
                }
                
            default:
                break
                
            }
        }
    }
    
    /// First step of animation
    private func firstStep() {
        self.startLabel.alpha = 0
        self.startView.transform = CGAffineTransform(scaleX: 4, y: 4)
        self.welcomeLabel.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
    }
    
    /// Second step of animation
    private func secondStep() {
        self.view.backgroundColor = #colorLiteral(red: 0.09048522819, green: 0.7226287412, blue: 0.9303202025, alpha: 1)
        self.remove(views: self.startView, self.startLabel, self.welcomeLabel)
        
        let sectionView = self.createSectionsView()
        let sectionImageView = self.createSectionsImageView()
        
        self.view.addSubview(sectionView)
        self.view.addSubview(sectionImageView)
    }
    
    /// Third step of animation
    private func thirdStep() {
        self.view.subviews.forEach {
            if let view = $0 as? UIView & Movable {
                view.move(translationX: 0, y: self.view.frame.height / 6 - self.view.frame.height)
            } else if let view = $0 as? UIView & Scalable {
                view.scale(x: 120, y: 120)
            }
        }
    }
    
    // MARK: - Animation helpers
    private func remove(views: UIView?...) {
        for case let view? in views {
            view.removeFromSuperview()
        }
    }
    
    private func createSectionsView() -> SectionsView {
        let view = SectionsView(frame: CGRect(
            x: 0,
            y: self.view.frame.height,
            width: self.view.frame.width,
            height: self.view.frame.height - (self.view.frame.height / 6))
        )
        
        view.backgroundColor = .white
        
        return view
    }
    
    private func createSectionsImageView() -> SectionsImageView {
        let view = SectionsImageView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        
        view.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 6)
        
        return view
    }

}
