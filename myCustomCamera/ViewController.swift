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
    var photoLayer:CGRect?
    var photoOutput: AVCapturePhotoOutput?
    var currentLayer:PhotoLayer = .rectangular
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    let photoSettings = AVCapturePhotoSettings()
    var flashMode = AVCaptureDevice.FlashMode.off
    var image: UIImage?
    var rectangularFrame:CGRect?
    var squaredFrame:CGRect?
   

    
    @IBOutlet weak var flashButton: UIButton!{
        didSet{
            flashButton.setImage(#imageLiteral(resourceName: "Flash Off Icon"), for: .normal)
        }
    }
    
    
    @IBOutlet weak var switchCameraButton: UIButton!
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        
        startRunningCaptureSession()
       
        setupPreviewLayer()
  
        
    }
    
    
    @IBAction func switchFrame(_ sender: UIButton) {
        setLayer()
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
            
            try? device.lockForConfiguration()
            if (device.isFocusModeSupported(.continuousAutoFocus)){
                device.focusMode = .continuousAutoFocus
            }else if (device.isFocusModeSupported(.autoFocus)){
                device.focusMode = .autoFocus
            }
            
            device.unlockForConfiguration()
        }
        
    }
    
    
    func setupInputOutput() {
        
        
        if let rearCamera = self.backCamera {

            self.backCameraInput = try? AVCaptureDeviceInput(device: rearCamera)

            if captureSession.canAddInput(self.backCameraInput!) { captureSession.addInput(self.backCameraInput!) }else {print ("Cannot add back input")}

            self.currentCameraPosition = .rear
            self.switchCameraButton.setImage(#imageLiteral(resourceName: "Rear Camera Icon"), for: .normal)
        }

            else if let frontCamera = self.frontCamera {
            self.frontCameraInput = try? AVCaptureDeviceInput(device: frontCamera)
            
            if captureSession.canAddInput(self.frontCameraInput!) { captureSession.addInput(self.frontCameraInput!) }
            else { print ("cannot add front input")}
            
            self.currentCameraPosition = .front
            self.switchCameraButton.setImage(#imageLiteral(resourceName: "Front Camera Icon"), for: .normal)
        }
        
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
       
    }
    
    
    
    
    
    func setLayer(){
        switch self.currentLayer{
        case .squared:
            self.currentLayer = .rectangular
            cameraPreviewLayer?.frame = rectangularFrame!
        case .rectangular:
            self.currentLayer = .squared
            cameraPreviewLayer?.frame = squaredFrame!
            
        }
       
    }
    
    func setupPreviewLayer() {
        squaredFrame = CGRect(x: 0, y:(view.bounds.height * 0.21889)-20, width: view.bounds.width, height: view.bounds.width)
        rectangularFrame = CGRect(x:0,y:(view.bounds.height*0.133433)-20,width:view.bounds.width, height:view.bounds.width / 0.75)
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = rectangularFrame!
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    //    MARK: - buttons
    
    @IBAction func changeCamera(_ sender: Any) {
        try? self.switchCameras()
        switch self.currentCameraPosition{
        case .some(.front):
            switchCameraButton.setImage(#imageLiteral(resourceName: "Front Camera Icon"), for: .normal)
            
        case .some(.rear):
            switchCameraButton.setImage(#imageLiteral(resourceName: "Rear Camera Icon"), for: .normal)
            
        case .none:
            return
            
        }
    }
        

        func switchCameras() throws {
            guard let currentCameraPosition = currentCameraPosition else {print("Camera position error"); return}
            guard captureSession.isRunning else { print ("errore");return }
            
            captureSession.beginConfiguration()
            
          
            
            
            func switchToFrontCamera() {
                    let inputs = captureSession.inputs as [AVCaptureInput]
                    guard let rearCameraInput = self.backCameraInput, inputs.contains(rearCameraInput),
                    let frontCamera = self.frontCamera else {
                       print("Error3")
                        return}
                
                self.frontCameraInput = try? AVCaptureDeviceInput(device: frontCamera)
                
                captureSession.removeInput(rearCameraInput)
                
                if captureSession.canAddInput(self.frontCameraInput!) {
                    captureSession.addInput(self.frontCameraInput!)
                    
                    self.currentCameraPosition = .front
                }
                    
                else {
//
                    print("Error4")
                    return
                }
            }
            
            func switchToRearCamera() {
                let inputs = captureSession.inputs as [AVCaptureInput]
                guard let frontCameraInput = self.frontCameraInput else{print("no front camera input"); return}
                guard inputs.contains(frontCameraInput)else {print ("No contains"); return}
                guard let rearCamera = self.backCamera else {
                        print("no back camera")
                        return }
                
                self.backCameraInput = try? AVCaptureDeviceInput(device: rearCamera)
                
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
                switchToRearCamera()
                
            case .rear:
                switchToFrontCamera()
            }
            
            captureSession.commitConfiguration()
        }
        
    

    @IBOutlet weak var cameraFrame: UIImageView!
    

    @IBAction func cameraButton(_ sender: Any) {
        photoSettings.flashMode = self.flashMode
        let uniCameraSetting = AVCapturePhotoSettings.init(from: photoSettings)
        photoOutput?.capturePhoto(with: uniCameraSetting, delegate: self)
        
        
    }
    
 
    @IBAction func flashButton(_ sender: Any) {
        switch self.flashMode{
        case .on:
            self.flashMode = .off
            self.flashButton.setImage(#imageLiteral(resourceName: "Flash Off Icon"), for: .normal)
        case .off :
            self.flashMode = .auto
            self.flashButton.setImage(nil, for: .normal)
            self.flashButton.setTitle("Auto", for: .normal)
        case .auto:
            self.flashMode = .on
            self.flashButton.setTitle(nil, for: .normal)
            self.flashButton.setImage(#imageLiteral(resourceName: "Flash On Icon"), for: .normal)
        }
      
    }
    
    

    
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//MARK:- Extension ViewController to take photo

extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
       
        if let imageData = photo.fileDataRepresentation() {
            print(imageData)
            image = UIImage(data: imageData)
            PhotoShared.shared.myPhotoArray.append(image!)
            print(PhotoShared.shared.myPhotoArray.count)
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        }
    }
}


public enum CameraPosition {
    case front
    case rear
}

public enum PhotoLayer{
    case squared
    case rectangular
}
