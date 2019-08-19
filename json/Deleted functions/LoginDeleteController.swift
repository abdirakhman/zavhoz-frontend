////
////  LoginRegisterController.swift
////  json
////
////  Created by Rakhman on 02/04/2019.
////  Copyright © 2019 Rakhman. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Firebase
//
//class LoginDeleteController: UIViewController {
//    
//    var viewOriginYAxis: CGFloat = 0.0
//    
//    let logoImageView: UIImageView = {
//        let vw = UIImageView()
//        vw.image = UIImage(named: "logo.png")
//        vw.translatesAutoresizingMaskIntoConstraints = false
//        return vw
//    }()
//    
//    let whiteView: UIView = {
//        let vw = UIView()
//        vw.layer.masksToBounds = true
//        vw.layer.cornerRadius = 8
//        vw.backgroundColor = .white
//        vw.translatesAutoresizingMaskIntoConstraints = false
//        return vw
//    }()
//    
//    let emailTextField: UITextField = {
//        let field = UITextField()
//        field.placeholder = "Email"
//        field.font = UIFont.systemFont(ofSize: 20)
//        field.translatesAutoresizingMaskIntoConstraints = false
//        field.autocapitalizationType = .none
//        return field
//    }()
//    
//    let passwordTextField: UITextField = {
//        let field = UITextField()
//        field.placeholder = "Password"
//        field.font = UIFont.systemFont(ofSize: 20)
//        field.translatesAutoresizingMaskIntoConstraints = false
//        field.isSecureTextEntry = true
//        return field
//    }()
//    
//    
//    let separatorLine: UIView = {
//        let vw = UIView()
//        vw.backgroundColor = .gray
//        vw.translatesAutoresizingMaskIntoConstraints = false
//        return vw
//    }()
//    
//    let loginRegisterButton: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle("Login", for: .normal)
//        btn.setTitleColor(.white, for: .normal)
//        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
//        btn.layer.masksToBounds = true
//        btn.layer.cornerRadius = 8
//        btn.backgroundColor = orangeButtonColor
//        btn.addTarget(self, action: #selector(loginRegisterFunction), for: .touchUpInside)
//        return btn
//    }()
//    
//    @objc func loginRegisterFunction() {
//        let ind = loginRegisterSegmentedControl.selectedSegmentIndex
//        let email = emailTextField.text ?? "", password = passwordTextField.text ?? ""
//        
//        if email == empty || password == empty {
//            Utils.errorProcess("Please, fill all blanks")
//        }
//        
//        if ind == 1 {
//            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//                
//                if error != nil {
//                    Utils.errorProcess("Some error there.")
////                    return
//                }else{
//                    self.dismiss(animated: true, completion: nil)
//                }
//            }
//        } else {
//            Auth.auth().signIn(withEmail: email, password: password, completion: { (user,  error) in
//                if error != nil {
//                    Utils.errorProcess("Invalid email or password")
//                    return
//                }else{
//                    self.dismiss(animated: true, completion: nil)
//                }
//            })
//        }
//    }
//    
//    @objc func dismissKeyboard(){
//        view.endEditing(true)
//    }
//    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= keyboardSize.height
//                self.view.frame.origin.y += (view.frame.height - (loginRegisterButton.frame.origin.y + loginRegisterButton.frame.height) + 8)
//            }
//        }
//    }
//    
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if self.view.frame.origin.y != 0 {
//            self.view.frame.origin.y = 0
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        viewOriginYAxis = view.frame.origin.y
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tap)
//        
//        view.backgroundColor = orangeTextColor
//        
//        view.addSubview(logoImageView)
//        view.addSubview(whiteView)
//        whiteView.addSubview(emailTextField)
//        whiteView.addSubview(separatorLine)
//        whiteView.addSubview(passwordTextField)
//        view.addSubview(loginRegisterSegmentedControl)
//        view.addSubview(loginRegisterButton)
//        
//        logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 42/50).isActive = true
//        logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor).isActive = true
//        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        logoImageView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: CGFloat(Int(Int(view.frame.width) * 8/100))).isActive = true
//        
//        loginRegisterSegmentedControl.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12).isActive = true
//        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 11/12).isActive = true
//        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 42).isActive = true
//        
//        whiteView.topAnchor.constraint(equalTo: loginRegisterSegmentedControl.bottomAnchor, constant: 12).isActive = true
//        whiteView.centerXAnchor.constraint(equalTo: loginRegisterSegmentedControl.centerXAnchor).isActive = true
//        whiteView.widthAnchor.constraint(equalTo: loginRegisterSegmentedControl.widthAnchor).isActive = true
//        whiteView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        
//        emailTextField.topAnchor.constraint(equalTo: whiteView.topAnchor).isActive = true
//        emailTextField.leftAnchor.constraint(equalTo: whiteView.leftAnchor, constant: 8).isActive = true
//        emailTextField.rightAnchor.constraint(equalTo: whiteView.rightAnchor, constant: -8).isActive = true
//        emailTextField.heightAnchor.constraint(equalTo: whiteView.heightAnchor, multiplier: 1/2).isActive = true
//        
//        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
//        separatorLine.rightAnchor.constraint(equalTo: emailTextField.rightAnchor).isActive = true
//        separatorLine.leftAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
//        separatorLine.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
//        
//        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
//        passwordTextField.leftAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
//        passwordTextField.rightAnchor.constraint(equalTo: emailTextField.rightAnchor).isActive = true
//        passwordTextField.heightAnchor.constraint(equalTo: whiteView.heightAnchor, multiplier: 1/2).isActive = true
//        
//        loginRegisterButton.topAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: 12).isActive = true
//        loginRegisterButton.rightAnchor.constraint(equalTo: whiteView.rightAnchor).isActive = true
//        loginRegisterButton.leftAnchor.constraint(equalTo: whiteView.leftAnchor).isActive = true
//        loginRegisterButton.heightAnchor.constraint(equalTo: whiteView.heightAnchor, multiplier: 1/2).isActive = true
//        
//    }
//}
