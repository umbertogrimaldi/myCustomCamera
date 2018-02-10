//
//  ViewController.swift
//  myCustomCamera
//
//  Created by UMBERTO GRIMALDI on 05/02/2018.
//  Copyright © 2018 UMBERTO GRIMALDI. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var currentCameraPosition: CameraPosition?
    var frontCameraInput:AVCaptureInput?
    var backCameraInput:AVCaptureInput?
    var captureSession = AVCaptureSession()
    var frontCamera: AVCaptureDevice?
    var backCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?

    
//    var myPhotoSession: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        
    }
    
    
    //    MARK:- FUNCTIONS
    
    func setupCaptureSession() {
        
            captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
    }
    
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
//        currentDevice = frontCamera
    }
    
    
    func setupInputOutput() {
        
        
        if let rearCamera = self.backCamera {

            self.backCameraInput = try? AVCaptureDeviceInput(device: rearCamera)

            if captureSession.canAddInput(self.backCameraInput!) { captureSession.addInput(self.backCameraInput!) }else {print ("Cannot add back input")}

            self.currentCameraPosition = .rear
        }

            else if let frontCamera = self.frontCamera {
            self.frontCameraInput = try? AVCaptureDeviceInput(device: frontCamera)
            
            if captureSession.canAddInput(self.frontCameraInput!) { captureSession.addInput(self.frontCameraInput!) }
            else { print ("cannot add front input")}
            
            self.currentCameraPosition = .front
        }
        
        
//            let captureDeviceInput = try AVCaptureDeviceInput.init(device: currentDevice!)
//            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
       
    }
    
    
    func setupPreviewLayer() {
        
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view
        .frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    
    //    MARK: - buttons
    
    @IBAction func changeCamera(_ sender: Any) {
        try? self.switchCameras()
    }
        

        func switchCameras() throws {
            guard let currentCameraPosition = currentCameraPosition, captureSession.isRunning else { print ("errore");return }
            
            captureSession.beginConfiguration()
            
          
            
            
            func switchToFrontCamera() throws {
                guard let inputs = captureSession.inputs as? [AVCaptureInput], let rearCameraInput = self.backCameraInput, inputs.contains(rearCameraInput),
                    let frontCamera = self.frontCamera else {
                       print("Error3")
                        return}
                
                self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
                
                captureSession.removeInput(rearCameraInput)
                
                if captureSession.canAddInput(self.frontCameraInput!) {
                    captureSession.addInput(self.frontCameraInput!)
                    
                    self.currentCameraPosition = .front
                }
                    
                else {
//                    throw CameraControllerError.invalidOperation
                    print("Error4")
                    return
                }
            }
            
            func switchToRearCamera() throws {
                guard let inputs = captureSession.inputs as? [AVCaptureInput]else {print ("no inputs"); return}
                guard let frontCameraInput = self.frontCameraInput else{print("no front camera input"); return}
                guard inputs.contains(frontCameraInput)else {print ("No contains"); return}
                guard let rearCamera = self.backCamera else {
                        print("no back camera")
                        return }
                
                self.backCameraInput = try AVCaptureDeviceInput(device: rearCamera)
                
                captureSession.removeInput(frontCameraInput)
                
                if captureSession.canAddInput(self.backCameraInput!) {
                    captureSession.addInput(self.backCameraInput!)
                    
                    self.currentCameraPosition = .rear
                }
                    
                else {
                    print("Error 2")
                    return }
            }
            
            switch currentCameraPosition {
            case .front:
                try switchToRearCamera()
                
            case .rear:
                try switchToFrontCamera()
            }
            
            captureSession.commitConfiguration()
        }
        
    

    

    @IBAction func cameraButton(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
 
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showPhotoSegue" {
//            let photoVC = segue.destination as! PreviewViewController
//
//        }
//    }
    
    @IBAction func doneButton(_ sender: Any) {
        performSegue(withIdentifier: "showPhotoSegue", sender: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//MARK:- Extension ViewController

extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            print(imageData)
            image = UIImage(data: imageData)
            PhotoShared.shared.myPhotoArray.append(image!)
            print(PhotoShared.shared.myPhotoArray.count)
//            performSegue(withIdentifier: "showPhotoSegue", sender: nil)
        }
    }
}


public enum CameraPosition {
    case front
    case rear
}

