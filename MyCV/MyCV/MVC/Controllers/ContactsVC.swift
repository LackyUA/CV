//
//  ContactsVC.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/26/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class ContactsVC: UITableViewController {

    // MARK: - Constants
    private let contacts = Contacts()
    private let reusableIdetifier = "ContactCell"
    private let titles = [
        "Address",
        "E-mail",
        "Skype",
        "Mobile",
        "Github",
        "Facebook"
    ]
    
    // MARK: - Properties
    private var data = [String: String]()
    
    // MARK: - Life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sleep(1)
        addBackButton()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.global().async {
            self.configure()
        }
    }
    
    // MARK: - Configuration
    private func configure() {
        self.save(contacts: contacts)
        
        DispatchQueue.main.async {
            self.title = self.contacts.title
            self.tableView.reloadData()
        }
    }
    
    private func save(contacts data: Contacts) {
        self.data[titles[0]] = data.address
        self.data[titles[1]] = data.email
        self.data[titles[2]] = data.skype
        self.data[titles[3]] = data.mobile
        self.data[titles[4]] = data.git
        self.data[titles[5]] = data.facebook
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
    
    // MARK: - Table view cells configuration
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdetifier, for: indexPath) as? ContactCell else { return UITableViewCell() }
        
        let title = titles[indexPath.row]
        guard let details = data[title] else { return UITableViewCell() }
        
        switch indexPath.row {
            
        case 0...2:
            cell.configure(title: title, details: details, image: nil)
            cell.isUserInteractionEnabled = false
            
        case 3:
            cell.configure(title: title, details: details, image: #imageLiteral(resourceName: "call"))
            
        case 4...5:
            cell.configure(title: title, details: details, image: #imageLiteral(resourceName: "web"))
            
        default:
            break
            
        }
        
        return cell
    }
    
    // MARK: - Selection configuration
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else { return }
        
        if
            let selectedCell = tableView.cellForRow(at: indexPath),
            indexPath.row > 2
        {
            selectedCell.isSelected = false
        }
        
        switch indexPath.row {
            
        case 3:
            cell.call(number: data[titles[indexPath.row]] ?? "")
            
        case 4...5:
            cell.open(url: data[titles[indexPath.row]] ?? "")
            
        default:
            break
            
        }
    }
    
    // MARK: - Footer configuration
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.4
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: .zero)
        footer.backgroundColor = .lightGray
        
        return footer
    }
    
    // MARK: - Header configuration
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.4
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: .zero)
        header.backgroundColor = .lightGray
        
        return header
    }
    
}
