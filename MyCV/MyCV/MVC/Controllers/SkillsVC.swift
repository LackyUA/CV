//
//  SkillsVC.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 5/1/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class SkillsVC: UIViewController {
    
    // MARK: - Constants
    private let reusableIdentifier = "SkillCell"
    private let sections: [String] = [
        "Languages",
        "Embedded frameworks",
        "Third party frameworks",
        "Design patterns",
        "Operantion systems"
    ]
    
    // MARK: - Properties
    private var data = [String: [String]]()
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global().async {
            self.loadData()
        }
    }
    
    // MARK: - Data loader functions
    private func loadData() {
        Skills().parseJSON { result in
            switch result {
                
            case .success(let data):
                self.save(skills: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.title = data.title
                }
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    private func save(skills data: Skills) {
        self.data[sections[0]] = data.languages
        self.data[sections[1]] = data.embeddedFrameworks
        self.data[sections[2]] = data.thirdPartyFrameworks
        self.data[sections[3]] = data.designPatterns
        self.data[sections[4]] = data.operationSystems
    }

}

// MARK: - Table view data source
extension SkillsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[sections[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as? SkillCell else { return UITableViewCell() }
        
        cell.configure(text: data[sections[indexPath.section]]?[indexPath.row] ?? "Empty boi")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SkillsSectionHeaderView()
        
        view.setTitle(with: sections[section])
        
        return view
    }
    
}

// MARK: - Table view delegation
extension SkillsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
}
