//
//  InformationTableViewController.swift
//  json
//
//  Created by Rakhman on 01/04/2019.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import Foundation
import UIKit

struct Furniture: Decodable {
    let arom_price: Int
    let init_cost: Int
    let responsible: String
    let place: String
    let date: String
    var name: String
    let month_expired: Int
    let error: String
    let place_history: String
    let responsible_history: String
    //let stuffArray: Array<String>
}

let empty: String = ""

class dataTableViewCell: UITableViewCell {
    
    let dataTextField: UITextField = {
        let tf = UITextField()
        tf.setLeftPaddingPoints(6)
        tf.font = UIFont.systemFont(ofSize: 22)
        tf.textColor = orangeTextColor
        tf.layer.borderColor = orangeTextColor.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.addSubview(dataTextField)
        
        dataTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dataTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 15/16).isActive = true
        dataTextField.heightAnchor.constraint(equalToConstant: 42).isActive = true
        dataTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class InformationTableViewController: UITableViewController {
    
    let placeholderData = [
        "Arom Price", "Initial Cost", "Responsible", "Place", "Date", "Name", "Month Expired"
    ]
    
    let cellId = "CellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        tableView.alwaysBounceVertical = false
        tableView.separatorStyle = .none
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = orangeTextColor
        self.navigationController?.navigationBar.tintColor = .white
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveData))
        let historyButton = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(showHistoryController))
        self.navigationItem.rightBarButtonItems = [saveButton, historyButton]
        
        tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
        
        tableView.register(dataTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! dataTableViewCell
            
        cell.selectionStyle = .none
        
        cell.dataTextField.text = dataArray[indexPath.row]
        
        cell.dataTextField.attributedPlaceholder = NSAttributedString(string: placeholderData[indexPath.row], attributes: [NSAttributedString.Key.foregroundColor: orangeTextColor])
        
        cell.dataTextField.isUserInteractionEnabled = false
    
        if placeholderData[indexPath.row] == "Place" || placeholderData[indexPath.row] == "Responsible" {
            
            cell.dataTextField.isUserInteractionEnabled = true
        }
        
        cell.dataTextField.tag = indexPath.row
        
        cell.dataTextField.addTarget(self, action: #selector(replaceData(_:)), for: .editingChanged)
        
        return cell
    }
    
}

extension InformationTableViewController {
    
    @objc func replaceData(_ textfield: UITextField) {
        dataArray[textfield.tag] = textfield.text!
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func showHistoryController() {
        navigationController?.pushViewController(HistoryViewController(), animated: true)
    }
    
    @objc func saveData(){
        let time = Date().timeIntervalSince1970
        let goodBefore = UserDefaults.standard.integer(forKey: "good_before") as Int
        if goodBefore <= Int(time) {
            refresh()
        }
        let accessToken = UserDefaults.standard.string(forKey: "access_token") ?? ""
        let jsonUrlString = "http://" + mainURL + "/update.php"
        guard let url = URL(string: jsonUrlString) else { return }
        var request:NSMutableURLRequest = NSMutableURLRequest(url:url)
        var bodyData = "id=" + qrString + "&arom_price=" + dataArray[0] + "&init_cost=" + dataArray[1] + "&responsible=" + dataArray[2] + "&place=" + dataArray[3] + "&date=" + dataArray[4] + "&name=" + dataArray[5] + "&month_expired=" + dataArray[6]
        request.httpMethod = "POST"
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
        {
            (response, data, error) in guard let data = data else { return }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func refresh() {
        let refreshToken = UserDefaults.standard.string(forKey: "refresh_token") ?? ""
        let jsonUrlString = "http://" + mainURL + "/refresh.php"
        guard let url = URL(string: jsonUrlString) else { return }
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url)
        let bodyData = "token=" + refreshToken
        request.httpMethod = "POST"
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
        {
            (response, data, error) in guard let data = data else { return }
            
            do {
                var course = try JSONDecoder().decode(User.self, from: data)
                
                DispatchQueue.main.async {
                    userArrayString[0] = String(course.error)
                    userArrayString[1] = String(course.access_token)
                    userArrayString[2] = String(course.refresh_token)
                    
                    userArrayInt[0] = Int(course.success)
                    userArrayInt[1] = Int(course.good_before)
                    
                    if userArrayInt[0] == 1 {
                        UserDefaults.standard.set(userArrayString[1], forKey: "access_token")
                        UserDefaults.standard.set(userArrayString[2], forKey: "refresh_token")
                        UserDefaults.standard.set(userArrayInt[1], forKey: "good_before")
                    } else {
                        self.handleLogout()
                    }
                }
            } catch {
                print("Error serialization json1")
            }
        }
    }
    
    @objc func handleLogout(){
        userArrayInt = [0, 0]
        userArrayString = ["", "", ""]
        UserDefaults.standard.set("", forKey: "access_token")
        UserDefaults.standard.set("", forKey: "refresh_token")
        UserDefaults.standard.set(0, forKey: "good_before")
        navigationController?.popToRootViewController(animated: true)
        present(LoginController(), animated: true, completion: nil)
    }
}
