//
//  WorkController.swift
//  json
//
//  Created by Rakhman Abdirashov on 7/23/19.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import UIKit

class WorkController: UIViewController {
    
    let workTextField = UITextField.createTextField("Work Place")
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Рабочее место"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Выберите ваш статус и введите свою рабочую компанию"
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
    
    let stuffSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Admin", "Worker"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = orangeTextColor
        sc.backgroundColor = .white
        sc.layer.masksToBounds =  true
        sc.layer.borderColor = orangeTextColor.cgColor
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        btn.layer.masksToBounds = true
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
        if workTextField.text == empty {
            Utils.errorProcess("Please, fill all blanks")
        } else {
            registerArray[3] = "\(stuffSegmentedControl.selectedSegmentIndex)"
            registerArray[4] = workTextField.text ?? ""
            present(CodeController(), animated: true, completion: nil)
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
        view.addSubview(stuffSegmentedControl)
        view.addSubview(workTextField)
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
        textLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 12).isActive = true
        textLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: -12).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 63).isActive = true
        
        stuffSegmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6).isActive = true
        stuffSegmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -6).isActive = true
        stuffSegmentedControl.heightAnchor.constraint(equalToConstant: 32).isActive = true
        stuffSegmentedControl.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 8).isActive = true
        
        workTextField.rightAnchor.constraint(equalTo: stuffSegmentedControl.rightAnchor).isActive = true
        workTextField.leftAnchor.constraint(equalTo: stuffSegmentedControl.leftAnchor).isActive = true
        workTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        workTextField.topAnchor.constraint(equalTo: stuffSegmentedControl.bottomAnchor, constant: 8).isActive = true
        
        nextButton.rightAnchor.constraint(equalTo: workTextField.rightAnchor).isActive = true
        nextButton.leftAnchor.constraint(equalTo: workTextField.leftAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalTo: workTextField.heightAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: workTextField.bottomAnchor, constant: 8).isActive = true
    }
}
