////
////  InformationController1.swift
////  json
////
////  Created by Rakhman Abdirashov on 6/27/19.
////  Copyright © 2019 Rakhman. All rights reserved.
////
//
//import Foundation
//
//
//
//let saveButton = UIButton.createButton("Save")
//@objc func saveFunction(){
//    let name = nameTextField.text
//    let year = yearTextField.text
//    let price = priceTextField.text
//    let group = groupTextField.text
//    
//    let id = Auth.auth().currentUser?.uid ?? ""
//    
//    if name == empty || year == empty || price == empty {
//        Utils.errorProcess("Please, fill all blanks")
//        return
//    } else {
//        
//        ref.child("users").child(id).child("Cell").child(qrString).setValue([
//            "Name": name,
//            "Year": year,
//            "Price": price,
//            "Group": group
//            ])
//        
//        if group != empty {
//            ref.child("users").child(id).child("Group").child(group ?? "").child(qrString).setValue([
//                "Name": name,
//                "Year": year,
//                "Price": price
//                ])
//        }
//        dismiss(animated: true, completion: nil)
//    }
//}
//
//func takeData() {
//    let id = Auth.auth().currentUser?.uid
//    
//    let jsonUrlString = "http://192.168.0.179/request.php?id=" + qrString
//    
//    guard let url = URL(string: jsonUrlString) else { return }
//    
//    let course: JSONDecoder
//    
//    URLSession.shared.dataTask(with: url) { (data, respone, err) in
//        
//        guard let data = data else { return }
//        
//        do {
//            
//            let course = try JSONDecoder().decode(Things.self, from: data)
//            
//            DispatchQueue.main.async {
//                self.nameTextField.text = String(course.name)
//                //self.yearTextField.text = String(course.enter_year)
//                self.priceTextField.text = String(course.init_cost)
//                //self.groupTextField.text = String(course.cur_cost)
//            }
//        } catch {
//            print("Error serialization json")
//        }
//        }.resume()
//}
//
//@objc func copyFunction(){
//    isCopy = true
//    copyString = qrString
//    present(OneCodeScaner(), animated: true, completion: nil)
//}
