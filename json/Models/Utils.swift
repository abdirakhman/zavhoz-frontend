//
//  Utils.swift
//  json
//
//  Created by Rakhman on 27/12/2018.
//  Copyright © 2018 Rakhman. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import LBTAComponents
import NVActivityIndicatorView

let loadAnimation: NVActivityIndicatorView = {
    let vw = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 70, height: 70), type: .ballRotateChase, color: UIColor(r: 61, g: 52, b: 49), padding: 0)
    return vw
}()

extension UIView {
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }
        return self.topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leftAnchor
        }
        return self.leftAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.rightAnchor
        }
        return self.rightAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        }
        return self.bottomAnchor
    }
}

extension UITextField {
    
    func setBottomLine(_ textColor: UIColor) {
        
        let bottomLine: UIView = {
            let line = UIView()
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = textColor
            return line
        }()
    
        self.addSubview(bottomLine)
    
        bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomLine.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bottomLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

func resetDefaults() {
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
        defaults.removeObject(forKey: key)
    }
}

struct Utils {
    
    static func errorProcess(_ message: String) {
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = message
        alert.addButton(withTitle: "Ok")
        alert.show()
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        return
    }
}

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    static func createUnderlinedTextField(_ placeholderText: String, _ textColor: UIColor) -> UITextField {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 22)
        tf.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: textColor])
        tf.textColor = textColor
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setBottomLine(textColor)
        return tf
    }
    
    static func createTextField(_ placeholderText: String) -> UITextField {
        let tf = UITextField()
        tf.setLeftPaddingPoints(6)
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.placeholder = placeholderText
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 8
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(r: 255, g: 250, b: 244)
        tf.layer.borderColor = UIColor(r: 210, g: 210, b: 214).cgColor
        return tf
    }
}

extension UIButton {
    
    static func createButton(_ title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.backgroundColor = orangeButtonColor
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }
    
    static func createUntitledButton() -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.backgroundColor = orangeButtonColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }
    
    static func createHighlightedButton(_ title: String, _ textColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 5
        button.layer.borderColor = textColor.cgColor
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
        return button
    }
}

extension UITextView {
    static func createTextView(_ placeholderText: String, _ textColor: UIColor) -> UITextView {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 22)
        tv.textColor = textColor
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 5
        tv.layer.borderColor = textColor.cgColor
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isScrollEnabled = false
        return tv
    }
}

extension InformationTableViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let pointInTable = textField.convert(textField.bounds.origin, to: self.tableView)
        let textFieldIndexPath = self.tableView.indexPathForRow(at: pointInTable)
        print(textFieldIndexPath!.row)
    }
}
