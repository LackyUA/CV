//
//  SummaryVC.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/30/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class SummaryVC: UIViewController {
    
    // MARK: - Constats
    private let data = Summary()
    
    // MARK: - Outlets
    @IBOutlet private weak var textView: UITextView! {
        didSet {
            textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: -15, right: 20)
        }
    }
    
    // MARK: - Life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = ""
        textView.backgroundColor = #colorLiteral(red: 0.09048522819, green: 0.7226287412, blue: 0.9303202025, alpha: 1)
        
        DispatchQueue.global().async {
            self.configure()
        }
    }
    
    // MARK: - Configuration
    private func configure() {
        let sentences = data.description.split(separator: ".")
        let attributeText = self.attributeText(from: sentences)
        
        DispatchQueue.main.async {
            self.title = self.data.title
            self.textView.attributedText = attributeText
        }
    }
    
    // MARK: - Parser helpers
    private func attributeText(from array: [Substring]) -> NSAttributedString {
        guard array.count > 0 else { return NSAttributedString() }
        
        let style = NSMutableParagraphStyle()
        style.alignment = .justified
        style.lineSpacing = 5.0
        style.paragraphSpacing = 15.0
        style.firstLineHeadIndent = 20.0
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.paragraphStyle: style,
            NSAttributedString.Key.font: UIFont(name: "GillSans-Italic", size: 17.0) ?? UIFont.systemFont(ofSize: 17.0),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        var string = String()
        for sentence in array {
            string += "\(sentence.trimmingCharacters(in: .whitespacesAndNewlines)).\n"
        }
        
        return NSAttributedString(string: string, attributes: attributes)
    }

}
