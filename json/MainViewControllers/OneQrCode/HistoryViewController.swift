//
//  HistoryViewController.swift
//  json
//
//  Created by Rakhman Abdirashov on 7/31/19.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController {
    
    let historySegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Place", "Responsible"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = orangeTextColor
        sc.backgroundColor = .white
        sc.layer.masksToBounds = true
        sc.layer.borderColor = orangeTextColor.cgColor
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(scChanged), for: .valueChanged)
        return sc
    }()

    let historyTextView: UITextView = {
        let vw = UITextView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.text = dataArray[7]
        vw.font = UIFont.systemFont(ofSize: 16)
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        
        view.backgroundColor = .white
        
        view.addSubview(historySegmentedControl)
        view.addSubview(historyTextView)

        historySegmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 4).isActive = true
        historySegmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 15/16).isActive = true
        historySegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        historySegmentedControl.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        historyTextView.topAnchor.constraint(equalTo: historySegmentedControl.bottomAnchor, constant: 4).isActive = true
        historyTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        historyTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        historyTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
}

extension HistoryViewController {
    @objc func scChanged() {
        let currentId = historySegmentedControl.selectedSegmentIndex
        if currentId == 0 {
            historyTextView.text = dataArray[7]
        } else {
            historyTextView.text = dataArray[8]
        }
    }
}
