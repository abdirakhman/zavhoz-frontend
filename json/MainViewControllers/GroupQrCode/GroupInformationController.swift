//
//  GroupInformationController.swift
//  json
//
//  Created by Rakhman on 02/04/2019.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import Foundation
import UIKit

class IDTableViewCell: UITableViewCell{
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scannedView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    let separatorLineView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = UIColor.lightGray
        return vw
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let responsibleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(idLabel)
        self.addSubview(scannedView)
        self.addSubview(separatorLineView)
        self.addSubview(nameLabel)
        self.addSubview(placeLabel)
        self.addSubview(responsibleLabel)
        
        idLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        idLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        idLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        scannedView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scannedView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        scannedView.widthAnchor.constraint(equalToConstant: 4).isActive = true
        scannedView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        separatorLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorLineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        separatorLineView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 4).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: idLabel.leftAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: idLabel.heightAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        placeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
        placeLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        placeLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        placeLabel.rightAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        responsibleLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 4).isActive = true
        responsibleLabel.leftAnchor.constraint(equalTo: placeLabel.leftAnchor).isActive = true
        responsibleLabel.heightAnchor.constraint(equalTo: placeLabel.heightAnchor).isActive = true
        responsibleLabel.rightAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GroupInformationController: UITableViewController {
    
    let cellId = "cellId"

    var unscannedData = [String]()
    var scannedData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countMissedID()
        
        tableView.separatorStyle = .none
        
        self.navigationItem.title = "QR Codes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = orangeTextColor
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backFunction))
        
        tableView.register(IDTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        if section == 0 {
            label.text = "Scanned: \(countId)"
            headerView.backgroundColor = .green
        } else {
            label.text = "Unscanned: \(maxId - countId)"
            headerView.backgroundColor = .red
        }
        
        headerView.addSubview(label)
        
        label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 14).isActive = true
        label.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 12).isActive = true
        label.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: headerView.rightAnchor).isActive = true
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return scannedData.count
        } else {
            return unscannedData.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! IDTableViewCell
        
        var id: String = ""
        
        if indexPath.section == 0 {
            id = scannedData[indexPath.row]
            cell.scannedView.backgroundColor = .green
        } else {
            id = unscannedData[indexPath.row]
            cell.scannedView.backgroundColor = .red
        }
        
        cell.idLabel.text = "ID: \(id)"
                
        let jsonUrlString = "http://" + mainURL + "/request.php?id=" + "\(id)"
        
        let url = URL(string: jsonUrlString)
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                var course = try JSONDecoder().decode(Furniture.self, from: data)
                
                DispatchQueue.main.async { // Correct
                    cell.nameLabel.text = "Name: " + course.name
                    cell.placeLabel.text = "Place: " + course.place
                    cell.responsibleLabel.text = "Responsible: " + course.responsible
                }
            } catch {
                print("Error serialization json")
            }
            
        }.resume()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            qrString = scannedData[indexPath.row]
        } else {
            qrString = unscannedData[indexPath.row]
        }
        
        takeData()
    }
}

extension GroupInformationController {
    
    func takeData() {
        let jsonUrlString = "http://" + mainURL + "/request.php?id=" + qrString
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                var course = try JSONDecoder().decode(Furniture.self, from: data)
                
                DispatchQueue.main.async {
                    dataArray[0] = String(course.arom_price)
                    dataArray[1] = String(course.init_cost)
                    dataArray[2] = String(course.responsible)
                    dataArray[3] = String(course.place)
                    dataArray[4] = String(course.date)
                    dataArray[5] = String(course.name)
                    dataArray[6] = String(course.month_expired)
                    self.navigationController?.pushViewController(InformationTableViewController(), animated: true)
                }
            } catch {
                print("Information")
                print("Error serialization json")
            }
            
        }.resume()
    }
    
    @objc func backFunction(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.popToRootViewController(animated: true)
    }
    
    func countMissedID(){
        countId = 0
        for x in 0..<maxId {
            if UserDefaults.standard.bool(forKey: "\(x + 1)") == true {
                scannedData.append("\(x + 1)")
                countId = countId + 1
            } else {
                unscannedData.append("\(x + 1)")
            }
        }
    }
}
