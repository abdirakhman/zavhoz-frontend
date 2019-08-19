//
//  ViewController.swift
//  Base-app
//
//  Created by Rakhman on 09/11/2018.
//  Copyright © 2018 Rakhman. All rights reserved.
//

import AVFoundation
import UIKit

struct idNumber: Decodable {
    let id: Int
    let error: String
}

var countId: Int = 0
var maxId: Int = 0

class GroupCodeScaner: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    let scanMessage: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.backgroundColor = .green
        label.text = "Successfully scanned"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "End", style: .plain, target: self, action: #selector(endFunction))
        
        getMaxId()
        
        
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "End", style: .plain, target: self, action: #selector(endFunction))
        
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
        
        view.addSubview(scanMessage)
        
        scanMessage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        scanMessage.heightAnchor.constraint(equalToConstant: 44).isActive = true
        scanMessage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3).isActive = true
        scanMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        captureSession.startRunning()
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

extension GroupCodeScaner {
    func messageAppear() {
        if scanMessage.isHidden {
            scanMessage.isHidden = false
            Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(showLabel), userInfo: nil, repeats: false)
        }
    }
    
    @objc func showLabel() {
        scanMessage.isHidden = true
    }
    
    func presentInformationController() {
        present(InformationTableViewController(), animated: true, completion: nil)
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            qrString = stringValue
            
            if UserDefaults.standard.bool(forKey: qrString) == false {
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                UserDefaults.standard.set(true, forKey: qrString)
                messageAppear()
            }
            
        }
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    func getMaxId(){
        let jsonUrlString = "http://" + mainURL + "/get_max_id.php"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let courses = try JSONDecoder().decode(idNumber.self, from: data)
                
                print(courses)
                DispatchQueue.main.async { // Correct
                    maxId = courses.id
                }
                
            } catch let jsonErr{
                print("Error serialization json", jsonErr)
            }
        }.resume()
    }
    
    @objc func endFunction() {
        self.navigationController?.pushViewController(GroupInformationController(), animated: true)
    }
}
