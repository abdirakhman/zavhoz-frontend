//
//  RegisterController.swift
//  json
//
//  Created by Rakhman Abdirashov on 7/23/19.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import UIKit

class AddStaffController: UIViewController {
    
    let nameTextField = UITextField.createTextField("Name")
    let surnameTextField = UITextField.createTextField("Surname")
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Добавьте работника"
        label.font = UIFont.boldSystemFont(ofSize: 29)
        label.textAlignment = .center
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Введите имя и фамилию работника и выберите роль"
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textColor = UIColor(r: 133, g: 139, b: 147)
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        let backImage = UIImage(named: "backbtn")
        let tintedImage = backImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = orangeTextColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backFunction), for: .touchUpInside)
        return button
    }()
    
    let staffSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Admin", "Worker"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = orangeTextColor
        sc.backgroundColor = .white
        sc.layer.masksToBounds =  true
        sc.layer.borderColor = orangeTextColor.cgColor
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let createButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Create", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        btn.backgroundColor = orangeTextColor
        btn.addTarget(self, action: #selector(createFunction), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(textLabel)
        view.addSubview(staffSegmentedControl)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(createButton)
        
        backButton.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 6).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 12/13).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 11/12).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        staffSegmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        staffSegmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        staffSegmentedControl.heightAnchor.constraint(equalToConstant: 32).isActive = true
        staffSegmentedControl.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 8).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: staffSegmentedControl.bottomAnchor, constant: 8).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -3).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        surnameTextField.topAnchor.constraint(equalTo: nameTextField.topAnchor).isActive = true
        surnameTextField.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 3).isActive = true
        surnameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        surnameTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
        
        createButton.rightAnchor.constraint(equalTo: surnameTextField.rightAnchor).isActive = true
        createButton.leftAnchor.constraint(equalTo: nameTextField.leftAnchor).isActive = true
        createButton.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
        createButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8).isActive = true
    }
}

extension AddStaffController {
    
    @objc func backFunction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func createFunction() {
        if nameTextField.text == empty || surnameTextField.text == empty {
            Utils.errorProcess("Please, fill all blanks")
        } else {
            let name = nameTextField.text! + " " + surnameTextField.text!
            //createUser(name)
        }
    }
}
