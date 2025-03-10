//
//  BarcodeScannerViewModel.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    @Published var scannedBarcode: String = ""
    @Published var alertItems: AlertItem?
    
    var statusText: String {
        return scannedBarcode.isEmpty ? "Not Yet Scan" : scannedBarcode
    }
    
    var statusTextColor: Color {
        scannedBarcode.isEmpty ? .red : .green
    }
}
