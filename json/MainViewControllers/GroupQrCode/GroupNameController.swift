//
//  GroupNameController.swift
//  json
//
//  Created by Rakhman on 02/04/2019.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import Foundation
import Firebase
import UIKit

var groupName: String = ""

class GroupNameController: UIViewController {
    
    let groupNameTextField = UITextField.createTextField("Group Name", orangeTextColor)
    
    let nextButton = UIButton.createButton("Next")
    
    @objc func nextFunction() {
        groupName = groupNameTextField.text ?? ""
        
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = .white
        
        nextButton.addTarget(self, action: #selector(nextFunction), for: .touchUpInside)
        
        view.addSubview(groupNameTextField)
        view.addSubview(nextButton)
        
        groupNameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        groupNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        groupNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 11/12).isActive = true
        groupNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nextButton.topAnchor.constraint(equalTo: groupNameTextField.bottomAnchor, constant: 16).isActive = true
        nextButton.rightAnchor.constraint(equalTo: groupNameTextField.rightAnchor).isActive = true
        nextButton.leftAnchor.constraint(equalTo: groupNameTextField.leftAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalTo: groupNameTextField.heightAnchor).isActive = true
    }
}
