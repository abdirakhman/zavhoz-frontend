//
//  InformationTableViewController.swift
//  json
//
//  Created by Rakhman on 01/04/2019.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class createQrCodeController: UITableViewController {
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createData))
        
        tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
        
        tableView.register(dataTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! dataTableViewCell
        
        cell.selectionStyle = .none
        
        cell.dataTextField.attributedPlaceholder = NSAttributedString(string: placeholderData[indexPath.row], attributes: [NSAttributedString.Key.foregroundColor: orangeTextColor])
        
        cell.dataTextField.tag = indexPath.row
        
        cell.dataTextField.addTarget(self, action: #selector(replaceData(_:)), for: .editingChanged)
        
        return cell
    }
}

extension createQrCodeController {
    
    @objc func createData() {
        
        if dataArray[0] != empty && dataArray[1] != empty && dataArray[2] != empty && dataArray[3] != empty && dataArray[4] != empty && dataArray[5] != empty && dataArray[6] != empty {
            let time = Date().timeIntervalSince1970
            let goodBefore = UserDefaults.standard.integer(forKey: "good_before") as Int
            if goodBefore <= Int(time) {
                refresh()
            }
            let accessToken = UserDefaults.standard.string(forKey: "access_token") ?? ""
            let jsonUrlString = "http://" + mainURL + "/insert.php"
            guard let url = URL(string: jsonUrlString) else { return }
            var request:NSMutableURLRequest = NSMutableURLRequest(url:url)
            var bodyData = "arom_price=" + dataArray[0] + "&init_cost=" + dataArray[1] + "&responsible=" + dataArray[2] + "&place=" + dataArray[3] + "&date=" + dataArray[4] + "&name=" + dataArray[5] + "&month_expired=" + dataArray[6]
            request.httpMethod = "POST"
            request.httpBody = bodyData.data(using: String.Encoding.utf8)
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
            {
                (response, data, error) in guard let data = data else { return }
            }
            navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please, fill all blanks", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            }))
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func replaceData(_ textfield: UITextField) {
        dataArray[textfield.tag] = textfield.text!
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
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
