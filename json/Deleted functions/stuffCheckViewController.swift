//
//  stuffCheckViewController.swift
//  json
//
//  Created by Rakhman Abdirashov on 8/3/19.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import Foundation
import UIKit

class stuffCheckViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        takeData()
    }
    
    func takeData() {
        
        let jsonUrlString = "http://" + mainURL + "/request.php?id=" + qrString
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                var course = try JSONDecoder().decode(Furniture.self, from: data)
                
                DispatchQueue.main.async {
                    
                }
            } catch {
                print("Error serialization json")
            }
            
            }.resume()
    }
}
