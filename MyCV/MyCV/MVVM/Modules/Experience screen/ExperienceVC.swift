//
//  ExperienceVC.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/4/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class ExperienceVC: UITableViewController {
    
    // MARK: - Properties
    var viewModel: ExperienceViewModel {
        return controller.viewModel
    }
    
    lazy var controller: ExperienceController = {
        return ExperienceController()
    }()

    // MARK: - Life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sleep(1)
        addBackButton()
        initBindings()
        controller.start()
    }
    
    // MARK: - Creating bindings for observing view model.
    func initBindings() {
        viewModel.experienceCellViewModels.addObserver(fireNow: false) { [weak self] (experienceCellViewModels) in
            self?.tableView.reloadData()
        }
        
        viewModel.title.addObserver { [weak self] (title) in
            self?.title = title
        }
    }
    
    // MARK: - Back button configuration
    private func addBackButton() {
        let backbutton = UIButton(type: .custom)
        
        backbutton.setTitle("Back", for: .normal)
        backbutton.setTitleColor(.white, for: .normal)
        backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    
    @objc func backAction() -> Void {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Status bar configuration
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.experienceCellViewModels.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExperienceCell.cellIdentifier(), for: indexPath)
        
        if let cell = cell as? Configurable {
            cell.configure(viewModel: viewModel.experienceCellViewModels.value[indexPath.row])
        }

        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "Details") as? DetailsVC else { return }
        
        vc.viewModel = viewModel.experienceCellViewModels.value[indexPath.row]
        
        if let navigator = self.navigationController {
            navigator.pushViewController(vc, animated: true)
        }
    }
    
}
