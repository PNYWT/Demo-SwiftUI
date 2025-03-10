//
//  ScannerVC.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 9/3/2568 BE.
//

import Foundation
import AVFoundation
import UIKit

enum CameraError {
    case invalidDeviceInput
    case invalidScannedValue
}

protocol ScannerVCDelegate: AnyObject {
    func didFind(barcode: String)
    func didSurface(error: CameraError)
}

class ScannerVC: UIViewController {
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegare: ScannerVCDelegate?
    
    init(scannerDelegate: ScannerVCDelegate) {
        self.scannerDelegare = scannerDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let havePreviewLayer = previewLayer else {
            scannerDelegare?.didSurface(error: .invalidDeviceInput)
            return
        }
        havePreviewLayer.frame = view.layer.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegare?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            scannerDelegare?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            scannerDelegare?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13]
        } else {
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            scannerDelegare?.didSurface(error: .invalidScannedValue)
            return
        }
        
        guard let machineReadableCodeObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegare?.didSurface(error: .invalidScannedValue)
            return
        }
        
        guard let barCode = machineReadableCodeObject.stringValue else {
            scannerDelegare?.didSurface(error: .invalidScannedValue)
            return
        }
//        captureSession.stopRunning()
        scannerDelegare?.didFind(barcode: barCode)
    }
}
