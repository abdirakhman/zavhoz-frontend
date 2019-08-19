//
//  EmailController.swift
//  json
//
//  Created by Rakhman Abdirashov on 7/23/19.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import UIKit

class EmailPasswordController: UIViewController {
    
    let passwordTextField = UITextField.createTextField("Password")
    let emailTextField = UITextField.createTextField("Email")
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Создание аккаунта"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Заполните email и придумайте пароль"
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
    
    let nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 8
        btn.backgroundColor = orangeTextColor
        btn.addTarget(self, action: #selector(nextFunction), for: .touchUpInside)
        return btn
    }()
    
    @objc func backFunction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func nextFunction() {
        registerArray[0] = emailTextField.text ?? ""
        registerArray[1] = passwordTextField.text ?? ""
        if registerArray[0] == empty || registerArray[1] == empty {
            Utils.errorProcess("Please, fill all blanks")
        } else {
            present(NameController(), animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(textLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(nextButton)
        
        backButton.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 6).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 278).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        textLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 20).isActive = true
        textLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: -20).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 16).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -6).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        passwordTextField.rightAnchor.constraint(equalTo: emailTextField.rightAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 4).isActive = true
        
        nextButton.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor).isActive = true
        nextButton.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8).isActive = true
    }
}
