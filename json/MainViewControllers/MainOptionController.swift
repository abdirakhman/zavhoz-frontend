
//
//  MainViewController.swift
//  json
//
//  Created by Rakhman on 06/02/2019.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import Foundation
import UIKit

var copyString: String = ""
var qrString: String = ""
var isCopy: Bool = false
var dataArray = ["", "", "", "", "", "", "", "", ""]
var userArrayString = ["", "", ""]
var userArrayInt = [0, 0]
var registerArray = ["", "", "", "", "", ""]
let mainURL = "14055c98.ngrok.io" + "/zavhoz/"
var listStaff = [String]()
let orangeButtonColor = UIColor(r: 255, g: 130, b: 0)
let orangeTextColor = UIColor(r: 255, g: 153, b: 0)

class MainOptionController: UIViewController {
    
    let scanQrCode: UIButton = {
        let btn = UIButton(type: .system)
        btn.layer.cornerRadius = 8
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = 2
        btn.layer.borderColor = orangeTextColor.cgColor
        btn.setTitle("Scan QR Code", for: .normal)
        btn.setTitleColor(orangeTextColor, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        btn.backgroundColor = .white
        btn.layer.borderColor = orangeTextColor.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(SegueScanQrCode), for: .touchUpInside)
        return btn
    }()
    
    let addStaffButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.layer.cornerRadius = 8
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = 2
        btn.layer.borderColor = orangeTextColor.cgColor
        btn.setTitle("Add Staff", for: .normal)
        btn.setTitleColor(orangeTextColor, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        btn.backgroundColor = .white
        btn.layer.borderColor = orangeTextColor.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(SegueAddStaffButton), for: .touchUpInside)
        return btn
    }()
    
    let scanGroupQrCode: UIButton = {
        let btn = UIButton(type: .system)
        btn.layer.cornerRadius = 8
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = 2
        btn.layer.borderColor = orangeTextColor.cgColor
        btn.setTitle("Scan Group QR Code", for: .normal)
        btn.setTitleColor(orangeTextColor, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        btn.backgroundColor = .white
        btn.layer.borderColor = orangeTextColor.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(SegueScanGroupQrCode), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkUser()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(handleLogout))
        self.navigationController?.navigationBar.barTintColor = orangeTextColor
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Список", style: .plain, target: self, action: #selector(SegueList))
        
        view.backgroundColor = .white
        
        view.addSubview(scanQrCode)
        view.addSubview(scanGroupQrCode)
        view.addSubview(addStaffButton)
        
        scanQrCode.topAnchor.constraint(equalTo: view.topAnchor, constant: 79).isActive = true
        scanQrCode.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scanQrCode.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/12).isActive = true
        scanQrCode.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 5/6).isActive = true
        
        scanGroupQrCode.rightAnchor.constraint(equalTo: scanQrCode.rightAnchor).isActive = true
        scanGroupQrCode.leftAnchor.constraint(equalTo: scanQrCode.leftAnchor).isActive = true
        scanGroupQrCode.topAnchor.constraint(equalTo: scanQrCode.bottomAnchor, constant: 16).isActive = true
        scanGroupQrCode.heightAnchor.constraint(equalTo: scanQrCode.heightAnchor).isActive = true
        
        addStaffButton.rightAnchor.constraint(equalTo: scanGroupQrCode.rightAnchor).isActive = true
        addStaffButton.leftAnchor.constraint(equalTo: scanGroupQrCode.leftAnchor).isActive = true
        addStaffButton.topAnchor.constraint(equalTo: scanGroupQrCode.bottomAnchor, constant: 16).isActive = true
        addStaffButton.heightAnchor.constraint(equalTo: scanGroupQrCode.heightAnchor).isActive = true
    }
}

extension MainOptionController {
    
    func getPostData() {
        let time = Date().timeIntervalSince1970
        let goodBefore = UserDefaults.standard.integer(forKey: "good_before") as Int
        if goodBefore <= Int(time) {
            refresh()
        }
        let accessToken = UserDefaults.standard.string(forKey: "access_token") ?? ""
        let jsonUrlString = "http://" + mainURL + "/request.php?"
        guard let url = URL(string: jsonUrlString) else { return }
        var request:NSMutableURLRequest = NSMutableURLRequest(url:url)
        var bodyData = "id=" + qrString
        request.httpMethod = "POST"
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
        {
            (response, data, error) in guard let data = data else { return }
            
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
                    dataArray[7] = String(course.place_history)
                    dataArray[8] = String(course.responsible_history)
                    self.navigationController?.pushViewController(InformationTableViewController(), animated: true)
                }
            } catch {
                print("Error serialization json")
            }
        }
    }
    
    @objc func handleLogout(){
        userArrayInt = [0, 0]
        userArrayString = ["", "", ""]
        UserDefaults.standard.set("", forKey: "access_token")
        UserDefaults.standard.set("", forKey: "refresh_token")
        UserDefaults.standard.set(0, forKey: "good_before")
        present(LoginController(), animated: true, completion: nil)
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
                print("Error serialization json")
            }
        }
    }
    
    func checkUser() {
        let time = Date().timeIntervalSince1970
        let goodBefore = UserDefaults.standard.integer(forKey: "good_before") as Int
        if goodBefore <= Int(time) {
            handleLogout()
        }
    }
    
    @objc func SegueList() {
        let time = Date().timeIntervalSince1970
        let goodBefore = UserDefaults.standard.integer(forKey: "good_before") as Int
        if goodBefore <= Int(time) {
            refresh()
        }
        let accessToken = UserDefaults.standard.string(forKey: "access_token") ?? ""
        let jsonUrlString = "http://" + mainURL + "/request.php"
        guard let url = URL(string: jsonUrlString) else { return }
        var request:NSMutableURLRequest = NSMutableURLRequest(url:url)
        var bodyData = ""
        request.httpMethod = "POST"
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
        {
            (response, data, error) in guard let data = data else { return }
            
            do {
                var course = try JSONDecoder().decode(Furniture.self, from: data)
                DispatchQueue.main.async {
                    
                    navigationController?.pushViewController(StaffTableViewController(), animated: true)
                }
            } catch {
                print("Error serialization json")
            }
        }
    }
    
    @objc func SegueScanQrCode(){
        isCopy = false
        self.navigationController?.pushViewController(OneCodeScaner(), animated: true)
    }
    
    @objc func SegueScanGroupQrCode() {
        self.navigationController?.pushViewController(GroupCodeScaner(), animated: true)
    }
    
    @objc func SegueAddStaffButton() {
        present(AddStaffController(), animated: true, completion: nil)
    }
}
