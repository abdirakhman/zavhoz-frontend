//
//  ViewController.swift
//  Base-app
//
//  Created by Rakhman on 09/11/2018.
//  Copyright © 2018 Rakhman. All rights reserved.
//

import AVFoundation
import UIKit
import NVActivityIndicatorView

var isCreated = false

class OneCodeScaner: UIViewController, AVCaptureMetadataOutputObjectsDelegate, NVActivityIndicatorViewable {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    var isOk: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("NO HOPE, BRO^")
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            print("NO HOPE, BRO^")
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            print("NO HOPE, BRO^")
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        view.addSubview(loadAnimation)
        loadAnimation.center = self.view.center
        loadAnimation.stopAnimating()
        
        captureSession.startRunning()
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension OneCodeScaner {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            captureSession.stopRunning()
            
            var name: String = ""
            
            qrString = stringValue
            
            takeData()
            
            let barCodeObject = previewLayer?.transformedMetadataObject(for: metadataObject as! AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
        }
    }
    
//    func addQrCode(code: String){
//        //loadAnimation.startAnimating()
//        let time = Date().timeIntervalSince1970
//        let goodBefore = UserDefaults.standard.integer(forKey: "good_before") as Int
//        if goodBefore >= Int(time) {
//            print("It is refresh")
//            refresh()
//        }
//        let accessToken = UserDefaults.standard.string(forKey: "access_token") ?? ""
//        let jsonUrlString = "http://" + mainURL + "/exists.php?"
//        guard let url = URL(string: jsonUrlString) else { return }
//        var request:NSMutableURLRequest = NSMutableURLRequest(url:url)
//        var bodyData = "id=" + qrString
//        request.httpMethod = "POST"
//        request.httpBody = bodyData.data(using: String.Encoding.utf8)
//        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
//        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
//        {
//            (response, data, error) in guard let data = data else { return }
//
//            do {
//                let courses = try JSONDecoder().decode(isExist.self, from: data)
//                DispatchQueue.main.async { // Correct
//                    if courses.found != "1" {
//                        isCreated = false
//                        self.showAddQrCodeAlert()
//                    } else {
//                        isCreated = true
//                        self.takeData()
//                    }
//                    //loadAnimation.stopAnimating()
//                }
//            } catch {
//                print("Error serialization json")
//            }
//            print(String(data: data, encoding: .utf8)!)
//        }
//    }
    
    func takeData() {
        let time = Date().timeIntervalSince1970
        let goodBefore = UserDefaults.standard.integer(forKey: "good_before") as Int
        if goodBefore <= Int(time) {
            print("It is second refresh")
            refresh()
        }
        let accessToken = UserDefaults.standard.string(forKey: "access_token") ?? ""
        let jsonUrlString = "http://" + mainURL + "/request.php"
        guard let url = URL(string: jsonUrlString) else { return }
        var request:NSMutableURLRequest = NSMutableURLRequest(url:url)
        var bodyData = "id=" + qrString
        request.httpMethod = "POST"
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
        {
            (response, data, error) in guard let data = data else { return }
            
            do {
                var course = try JSONDecoder().decode(Furniture.self, from: data)
                DispatchQueue.main.async {
                    if course.error == "Not found" {
                        self.showAddQrCodeAlert()
                    } else {
                        dataArray[0] = String("\(course.arom_price)")
                        dataArray[1] = String("\(course.init_cost)")
                        dataArray[2] = String(course.responsible)
                        dataArray[3] = String(course.place)
                        dataArray[4] = String(course.date)
                        dataArray[5] = String(course.name)
                        dataArray[6] = String("\(course.month_expired)")
                        dataArray[7] = String(course.place_history)
                        dataArray[8] = String(course.responsible_history)
                        self.navigationController?.pushViewController(InformationTableViewController(), animated: true)
                    }
                }
            } catch {
                print("Error serialization json2")
                print(error)
            }
        }
    }
    
    @objc func handleLogout(){
        userArrayInt = [0, 0]
        userArrayString = ["", "", ""]
        UserDefaults.standard.set("", forKey: "access_token")
        UserDefaults.standard.set("", forKey: "refresh_token")
        UserDefaults.standard.set(0, forKey: "good_before")
        navigationController?.popToRootViewController(animated: true)
        present(LoginController(), animated: true, completion: nil)
    }
    
    func refresh() {
        let refreshToken = UserDefaults.standard.string(forKey: "refresh_token") ?? ""
        let jsonUrlString = "http://" + mainURL + "/refresh.php"
        guard let url = URL(string: jsonUrlString) else { return }
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url)
        let bodyData = "token=" + refreshToken
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
                    } else {
                        self.handleLogout()
                    }
                }
            } catch {
                print("Error serialization json1")
            }
        }
    }
    
    func showAddQrCodeAlert() {
        let alert = UIAlertController(title: "Add that QR Code?", message: "That QR Code not existing, but you can add it.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            self.captureSession.startRunning()
        }))
        alert.addAction(UIAlertAction(title: "Add",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        self.navigationController?.pushViewController(createQrCodeController(), animated: true)
                                        dataArray[0] = ""
                                        dataArray[1] = ""
                                        dataArray[2] = ""
                                        dataArray[3] = ""
                                        dataArray[4] = ""
                                        dataArray[5] = ""
                                        dataArray[6] = ""
        }))
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        self.present(alert, animated: true, completion: nil)
    }
}
