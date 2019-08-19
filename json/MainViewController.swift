
//
//  MainViewController.swift
//  json
//
//  Created by Rakhman on 06/02/2019.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: ViewController {
    
    @objc func ShowThingInformation(){
        self.navigationController?.pushViewController(ScanCodesCameraController(), animated: true)
    }
    
    let qrCode: UIButton = {
        let btn = UIButton(type: .system)
        btn.layer.cornerRadius = 30
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = 2
        btn.layer.borderColor = orangeTextColor.cgColor
        btn.setTitle("QR Code", for: .normal)
        btn.setTitleColor(orangeTextColor, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        btn.backgroundColor = .white
        btn.layer.borderColor = orangeTextColor.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(ShowThingInformation), for: .touchUpInside)
        return btn
    }()
    
    let countQrCode: UIButton = {
        let btn = UIButton(type: .system)
        btn.layer.cornerRadius = 30
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = 2
        btn.layer.borderColor = orangeTextColor.cgColor
        btn.setTitle("Count qr codes", for: .normal)
        btn.setTitleColor(orangeTextColor, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        btn.backgroundColor = .white
        btn.layer.borderColor = orangeTextColor.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(ShowThingInformation), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession.stopRunning()
        
        view.backgroundColor = .white
        
        view.addSubview(qrCode)
        view.addSubview(countQrCode)
        
        qrCode.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        qrCode.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        qrCode.heightAnchor.constraint(equalToConstant: 60).isActive = true
        qrCode.widthAnchor.constraint(equalToConstant: view.frame.width - 36).isActive = true
        
        countQrCode.topAnchor.constraint(equalTo: qrCode.bottomAnchor, constant: 24).isActive = true
        countQrCode.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        countQrCode.heightAnchor.constraint(equalToConstant: 60).isActive = true
        countQrCode.widthAnchor.constraint(equalToConstant: view.frame.width - 36).isActive = true
    }
}
