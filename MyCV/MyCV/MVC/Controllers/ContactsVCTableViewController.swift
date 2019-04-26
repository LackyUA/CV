//
//  ContactsVC.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/26/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import UIKit

class ContactsVC: UITableViewController {

    private let titles = [
        "Address",
        "E-mail",
        "Skype",
        "Mobile",
        "Github",
        "Facebook"
    ]
    
    private var contacts = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseContacts()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private func parseContacts() {
        DispatchQueue.global().async {
            Contacts().parseJSON { result in
                switch result {
                    
                case .success(let data):
                    self.save(contacts: data)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
                    
                }
            }
        }
    }
    
    private func save(contacts data: Contacts) {
        contacts[titles[0]] = data.address
        contacts[titles[1]] = data.email
        contacts[titles[2]] = data.skype
        contacts[titles[3]] = data.mobile
        contacts[titles[4]] = data.git
        contacts[titles[5]] = data.facebook
    }
    
    // MARK: - Configuration table view cells
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else { return UITableViewCell() }
        
        let title = titles[indexPath.row]
        guard let details = contacts[title] else { return UITableViewCell() }
        
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
            cell.call(number: contacts[titles[indexPath.row]] ?? "")
            
        case 4...5:
            cell.open(url: contacts[titles[indexPath.row]] ?? "")
            
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
