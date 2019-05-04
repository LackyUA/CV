//
//  DetailsVC.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/4/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    // MARK: - Properties
    var viewModel = ExperienceCellViewModel()
    
    // MARK: - Outlets
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func openUrlOnTap(_ sender: Any) {
        if let url = URL(string: viewModel.link) {
            UIApplication.shared.open(url, options: [:])
        } else {
            showAlert("Sorry, I can't distribute this code.")
        }
    }
    
    // MARK: - Life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModel.title
        configure()
    }
    
    // MARK: - Configuration
    private func configure() {
        periodLabel.text = viewModel.period
        descriptionLabel.text = viewModel.description
    }
    
    // MARK: - Alert function
    private func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
