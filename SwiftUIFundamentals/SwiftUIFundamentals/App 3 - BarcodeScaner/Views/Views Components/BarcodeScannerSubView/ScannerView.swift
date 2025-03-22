//
//  ScannerView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 9/3/2568 BE.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ScannerVC
    
    @Binding var scannedBarcode: String
    @Binding var alertItems: AlertItem?
    
    final class Coordinator: NSObject, ScannerVCDelegate {
        
        private let scannerView: ScannerView
        
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func didFind(barcode: String) {
            print(barcode)
            scannerView.scannedBarcode = barcode
        }
        
        func didSurface(error: CameraError) {
            switch error {
            case .invalidDeviceInput:
                scannerView.alertItems = AlertContext.invalidDeviceInput
            case .invalidScannedValue:
                scannerView.alertItems = AlertContext.invalidScannedType
            }
        }
    }

    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
}

#Preview {
    ScannerView(scannedBarcode: .constant(""), alertItems: .constant(.none))
}
