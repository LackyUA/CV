//
//  AdditionalVC.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/4/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class AdditionalVC: UIViewController {
    
    // MARK: - Constants
    private let viewModel = AdditionalViewModel(model: Additional())
    
    // MARK: - Outlets
    @IBOutlet private var titleLabels: [UILabel]!
    @IBOutlet private var descriptionLabels: [UILabel]!
    
    // MARK: - Life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sleep(1)
        addBackButton()
        configure()
    }
    
    // MARK: - Configuration
    private func configure() {
        let data = viewModel.data
        let keys = viewModel.dataKeys
        
        for (index, key) in keys.enumerated() {
            titleLabels[index].text = key
            descriptionLabels[index].text = data[key]
        }
        
        self.title = viewModel.title
    }
    
    // MARK: - Back button configuration
    private func addBackButton() {
        let backbutton = UIButton(type: .custom)
        
        backbutton.setTitle("Back", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
        backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    
    @objc func backAction() -> Void {
        dismiss(animated: true, completion: nil)
    }

}
