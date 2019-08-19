//
//  LoginRegisterController.swift
//  json
//
//  Created by Rakhman on 02/04/2019.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import Foundation
import UIKit

struct User: Decodable {
    let error: String
    let access_token: String
    let refresh_token: String
    let success: Int
    let good_before: Int
}

class LoginController: UIViewController {
    
    var viewOriginYAxis: CGFloat = 0.0
    
    let emptySpaceView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(r: 255, g: 180, b: 110)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.addTarget(self, action: #selector(registerButtonActivated), for: .touchUpInside)
        return button
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        return button
    }()
    
    let logoImageView: UIImageView = {
        let vw = UIImageView()
        vw.image = UIImage(named: "logo.png")
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    let whiteView: UIView = {
        let vw = UIView()
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 8
        vw.backgroundColor = .white
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    let emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.font = UIFont.systemFont(ofSize: 17)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.autocapitalizationType = .none
        return field
    }()
    
    let passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.font = UIFont.systemFont(ofSize: 17)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.isSecureTextEntry = true
        return field
    }()
    
    
    let separatorLine: UIView = {
        let vw = UIView()
        vw.backgroundColor = .gray
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        btn.backgroundColor = orangeButtonColor
        btn.addTarget(self, action: #selector(loginFunction), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = orangeTextColor
        
        view.addSubview(emptySpaceView)
        view.addSubview(logoImageView)
        view.addSubview(whiteView)
        whiteView.addSubview(emailTextField)
        whiteView.addSubview(separatorLine)
        whiteView.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(registerButton)
        
        whiteView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 12).isActive = true
        whiteView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whiteView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 11/12).isActive = true
        whiteView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    
        emailTextField.topAnchor.constraint(equalTo: whiteView.topAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: whiteView.leftAnchor, constant: 8).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: whiteView.rightAnchor, constant: -8).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: whiteView.heightAnchor, multiplier: 1/2).isActive = true
        
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorLine.rightAnchor.constraint(equalTo: emailTextField.rightAnchor).isActive = true
        separatorLine.leftAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
        separatorLine.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: emailTextField.rightAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: whiteView.heightAnchor, multiplier: 1/2).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: 12).isActive = true
        loginButton.rightAnchor.constraint(equalTo: whiteView.rightAnchor).isActive = true
        loginButton.leftAnchor.constraint(equalTo: whiteView.leftAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalTo: whiteView.heightAnchor, multiplier: 1/2).isActive = true
        
        emptySpaceView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        emptySpaceView.rightAnchor.constraint(equalTo: whiteView.rightAnchor).isActive = true
        emptySpaceView.leftAnchor.constraint(equalTo: whiteView.leftAnchor).isActive = true
        emptySpaceView.bottomAnchor.constraint(equalTo: whiteView.topAnchor).isActive = true
        
        logoImageView.widthAnchor.constraint(equalTo: emptySpaceView.widthAnchor, multiplier: 3/5).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: emptySpaceView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: emptySpaceView.centerYAnchor).isActive = true
        
        forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12).isActive = true
        forgotPasswordButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        forgotPasswordButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        registerButton.leftAnchor.constraint(equalTo: loginButton.leftAnchor).isActive = true
        registerButton.rightAnchor.constraint(equalTo: loginButton.rightAnchor).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -16).isActive = true
        registerButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor).isActive = true
    }
}

extension LoginController {
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y += (view.frame.height - (loginButton.frame.origin.y + loginButton.frame.height) - 4) - keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func loginFunction() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        if password == empty || email == empty {
            print("Bachok")
        }
        let jsonUrlString = "http://" + mainURL + "/login.php"
        guard let url = URL(string: jsonUrlString) else { return }
        var request:NSMutableURLRequest = NSMutableURLRequest(url:url)
        var bodyData = "login=" + email + "&pass=" + password
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
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        Utils.errorProcess(userArrayString[0])
                    }
                }
            } catch {
                print("Error serialization json")
            }
        }
    }
    
    @objc func registerButtonActivated() {
        present(EmailPasswordController(), animated: true, completion: nil)
    }
}
