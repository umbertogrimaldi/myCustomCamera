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
    
    var captureSession = AVCaptureSession()
    var frontCamera: AVCaptureDevice?
    var backCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    var myPhotoArray: [UIImage] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }
    
    
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
        
        currentDevice = backCamera
    }
    
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput.init(device: currentDevice!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
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
    
    

    @IBAction func cameraButton(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotoSegue" {
            let photoVC = segue.destination as! PreviewViewController
            photoVC.myPhotoArray = self.myPhotoArray
        }
    }
    
    @IBAction func doneButton(_ sender: Any) {
        performSegue(withIdentifier: "showPhotoSegue", sender: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            print(imageData)
            image = UIImage(data: imageData)
            myPhotoArray.append(image!)
            print(myPhotoArray.count)
//            performSegue(withIdentifier: "showPhotoSegue", sender: nil)
        }
    }
}


