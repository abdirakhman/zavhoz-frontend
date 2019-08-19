//
//  InformationController.swift
//  json
//
//  Created by Rakhman on 01/04/2019.
//  Copyright © 2019 Rakhman. All rights reserved.
//

import Foundation
import UIKit
import Firebase
//
//struct Furniture: Decodable {
//    let arom_price: String
//    let init_cost: String
//    let responsible: String
//    let place: String
//    let date: String
//    var name: String
//    let month_expired: String
//    let error: String
//}

//let empty: String = ""

class InformationController: UIViewController {
    
    let saveButton = UIButton.createUntitledButton()
    
    let nameTextField = UITextField.createTextField("Name", orangeTextColor)
    let aromPriceTextField = UITextField.createTextField("Arom Price", orangeTextColor)
    let responsibleTextField = UITextField.createTextField("Responsible", orangeTextColor)
    let placeTextField = UITextField.createTextField("Place", orangeTextColor)
    let dateTextField = UITextField.createTextField("Date", orangeTextColor)
    let initialCostTextField = UITextField.createTextField("Initial Cost", orangeTextColor)
    let monthLeftTextField = UITextField.createTextField("Month Left", orangeTextColor)
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func saveData(){

        var updateUrl: String = "http://fd679f70.ngrok.io/update.php?id="
        updateUrl = updateUrl + qrString
        updateUrl = updateUrl + "&arom_price=" + (aromPriceTextField.text!)
        updateUrl = updateUrl + "&init_cost=" + initialCostTextField.text!
        updateUrl = updateUrl + "&responsible=" + responsibleTextField.text!
        updateUrl = updateUrl + "&place=" + placeTextField.text!
        updateUrl = updateUrl + "&date=" + dateTextField.text!
        updateUrl = updateUrl + "&name=" + nameTextField.text!
        updateUrl = updateUrl + "&month_expired=" + monthLeftTextField.text!
        
        guard let url = URL(string: updateUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
        }.resume()
    }
    
    @objc func createData() {
        var createUrl: String = "http://8dd45fd1.ngrok.io//insert.php?"
        
        createUrl = createUrl + "arom_price=" + (aromPriceTextField.text!)
        createUrl = createUrl + "&init_cost=" + initialCostTextField.text!
        createUrl = createUrl + "&responsible=" + responsibleTextField.text!
        createUrl = createUrl + "&place=" + placeTextField.text!
        createUrl = createUrl + "&date=" + dateTextField.text!
        createUrl = createUrl + "&name=" + nameTextField.text!
        createUrl = createUrl + "&month_expired=" + monthLeftTextField.text!
        
        print(createUrl)
        
        guard let url = URL(string: createUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
        }.resume()
    }
    
    func takeData() {

        let jsonUrlString = "http://fd679f70.ngrok.io/request.php?id=" + qrString

        guard let url = URL(string: jsonUrlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, err) in

            guard let data = data else { return }

            do {
                var course = try JSONDecoder().decode(Furniture.self, from: data)

                DispatchQueue.main.async { // Correct
                    self.nameTextField.text = String(course.name)
                    self.dateTextField.text = String(course.date)
                    self.initialCostTextField.text = String(course.init_cost)
                    self.aromPriceTextField.text = String(course.arom_price)
                    self.placeTextField.text = String(course.place)
                    self.responsibleTextField.text = String(course.responsible)
                    self.monthLeftTextField.text = String(course.month_expired)
                }
            } catch {
                print("Information")
                print("Error serialization json")
            }

        }.resume()

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isCreated == true {
            saveButton.setTitle("Save", for: .normal)
        } else {
            saveButton.setTitle("Create", for: .normal)
        }
        
        view.backgroundColor = .yellow
        
        takeData()

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        view.backgroundColor = .white
        
        if isCreated == true {
            saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        } else {
            saveButton.addTarget(self, action: #selector(createData), for: .touchUpInside)
        }
        

        view.addSubview(nameTextField)
        view.addSubview(initialCostTextField)
        view.addSubview(aromPriceTextField)
        view.addSubview(responsibleTextField)
        view.addSubview(dateTextField)
        view.addSubview(placeTextField)
        view.addSubview(monthLeftTextField)
        view.addSubview(saveButton)

        nameTextField.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 16).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 11/12).isActive = true

        initialCostTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 12).isActive = true
        initialCostTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor).isActive = true
        initialCostTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
        initialCostTextField.centerXAnchor.constraint(equalTo: nameTextField.centerXAnchor).isActive = true

        aromPriceTextField.topAnchor.constraint(equalTo: initialCostTextField.bottomAnchor, constant: 12).isActive = true
        aromPriceTextField.widthAnchor.constraint(equalTo: initialCostTextField.widthAnchor).isActive = true
        aromPriceTextField.heightAnchor.constraint(equalTo: initialCostTextField.heightAnchor).isActive = true
        aromPriceTextField.centerXAnchor.constraint(equalTo: initialCostTextField.centerXAnchor).isActive = true

        responsibleTextField.topAnchor.constraint(equalTo: aromPriceTextField.bottomAnchor, constant: 12).isActive = true
        responsibleTextField.widthAnchor.constraint(equalTo: aromPriceTextField.widthAnchor).isActive = true
        responsibleTextField.heightAnchor.constraint(equalTo: aromPriceTextField.heightAnchor).isActive = true
        responsibleTextField.centerXAnchor.constraint(equalTo: aromPriceTextField.centerXAnchor).isActive = true

        dateTextField.topAnchor.constraint(equalTo: responsibleTextField.bottomAnchor, constant: 12).isActive = true
        dateTextField.widthAnchor.constraint(equalTo: responsibleTextField.widthAnchor).isActive = true
        dateTextField.heightAnchor.constraint(equalTo: responsibleTextField.heightAnchor).isActive = true
        dateTextField.centerXAnchor.constraint(equalTo: responsibleTextField.centerXAnchor).isActive = true

        placeTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 12).isActive = true
        placeTextField.widthAnchor.constraint(equalTo: dateTextField.widthAnchor).isActive = true
        placeTextField.heightAnchor.constraint(equalTo: dateTextField.heightAnchor).isActive = true
        placeTextField.centerXAnchor.constraint(equalTo: dateTextField.centerXAnchor).isActive = true

        monthLeftTextField.topAnchor.constraint(equalTo: placeTextField.bottomAnchor, constant: 12).isActive = true
        monthLeftTextField.widthAnchor.constraint(equalTo: placeTextField.widthAnchor).isActive = true
        monthLeftTextField.heightAnchor.constraint(equalTo: placeTextField.heightAnchor).isActive = true
        monthLeftTextField.centerXAnchor.constraint(equalTo: placeTextField.centerXAnchor).isActive = true
        
        saveButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 12).isActive = true
        saveButton.rightAnchor.constraint(equalTo: monthLeftTextField.rightAnchor).isActive = true
        saveButton.topAnchor.constraint(equalTo: monthLeftTextField.bottomAnchor, constant: 12).isActive = true
        saveButton.heightAnchor.constraint(equalTo: monthLeftTextField.heightAnchor).isActive = true
    }
    
    
}
