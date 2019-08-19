//
//  CodeController.swift
//  json
//
//  Created by Rakhman Abdirashov on 7/23/19.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import UIKit

class CodeController: UIViewController {
    
    let codeTextField = UITextField.createTextField("Code")
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Рабочий код"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Введите рабочий код"
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textColor = UIColor(r: 133, g: 139, b: 147)
        return label
    }()
    
    let bonusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "(Спросите у бухгалтера)"
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
    
    let registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Register", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        btn.backgroundColor = orangeTextColor
        btn.addTarget(self, action: #selector(registerFunction), for: .touchUpInside)
        return btn
    }()
    
    @objc func backFunction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func registerFunction() {
        if codeTextField.text == empty {
            Utils.errorProcess("Please, fill all blanks")
        } else {
            registerArray[5] = codeTextField.text ?? ""
            let jsonUrlString = "http://" + mainURL + "/register.php?login=" + registerArray[0] + "&pass=" + registerArray[1] + "&type=" + registerArray[3] + "&code=" + registerArray[5] + "&name=" + registerArray[2] + "&place=" + registerArray[4]
            
            print(jsonUrlString)
            
            guard let url = URL(string: jsonUrlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
            }.resume()
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
        view.addSubview(bonusLabel)
        view.addSubview(codeTextField)
        view.addSubview(registerButton)
        
        backButton.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 6).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 278).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        textLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 12).isActive = true
        textLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: -12).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        bonusLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor).isActive = true
        bonusLabel.leftAnchor.constraint(equalTo: textLabel.leftAnchor).isActive = true
        bonusLabel.rightAnchor.constraint(equalTo: textLabel.rightAnchor).isActive = true
        bonusLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        codeTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -6).isActive = true
        codeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6).isActive = true
        codeTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        codeTextField.topAnchor.constraint(equalTo: bonusLabel.bottomAnchor, constant: 16).isActive = true
        
        registerButton.rightAnchor.constraint(equalTo: codeTextField.rightAnchor).isActive = true
        registerButton.leftAnchor.constraint(equalTo: codeTextField.leftAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalTo: codeTextField.heightAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 8).isActive = true
    }
}
