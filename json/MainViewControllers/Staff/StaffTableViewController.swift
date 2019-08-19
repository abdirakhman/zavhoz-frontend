//
//  StaffTableViewController.swift
//  json
//
//  Created by Rakhman Abdirashov on 8/12/19.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import UIKit

class WorkerTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(nameLabel)
        
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class StaffTableViewController: UITableViewController {
    
    let cellId = "cellId"
    
    let ArrayTitle = ["Stranger Things", "Sherlock", "Game of Thrones", "Apple", "Avengers"]
    
    let namesArray = [
        ["Millie Bobby Brown", "Dacre Montgomery", "Finn Wolfhard", "David Harbour", "Winona Ryder", "Alec Utgoff"],
        ["Benedict Cumberbatch Holmes Backer", "Mark Gatiss", "Martin Freeman", "Louise Brealey", "Amanda Abbington"],
        ["Emilia Clarke", "Maisie Williams", "Sophie Turner", "Kit Harington", "Peter Dinklage"],
        ["Steve Jobs", "Steve Wozniak", "Ronald Wayne"],
        ["Robert Downey Jr.", "Chris Evans", "Mark Ruffalo", "Chris Hemsworth", "Scarlett Johansson", "Jeremy Renner"]
    ]
    
    let loginArray = [
        ["Eleven", "Billy", "Mike", "Hopper", "Joyce", "Alexei"],
        ["Sherlock", "Mycroft", "Watson", "Molly", "Mary"],
        ["Daenerys", "Arya", "Sansa", "Jon", "Cersei", "Tyrion"],
        ["Steve", "Wozniak", "Wayne"],
        ["Iron Man", "Captain America", "Hulk", "Thor", "Black Widow", "Hawkeye"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Сотрудники"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.barTintColor = orangeTextColor
        
        tableView.register(WorkerTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ArrayTitle[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = UIColor(r: 255, g: 236, b: 222)
        
        let titleLabel = UILabel()
        titleLabel.text = ArrayTitle[section]
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(titleLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor).isActive = true
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! WorkerTableViewCell
        
        cell.nameLabel.text = namesArray[indexPath.section][indexPath.row]
        cell.loginLabel.text = " ~ " + loginArray[indexPath.section][indexPath.row]
        
        return cell
    }
}
