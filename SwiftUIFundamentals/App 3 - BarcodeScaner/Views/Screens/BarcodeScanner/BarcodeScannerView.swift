//
//  BarcodeScannerView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 9/3/2568 BE.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    @StateObject var viewModel = BarcodeScannerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScannerView(scannedBarcode: $viewModel.scannedBarcode, alertItems: $viewModel.alertItems)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .background(Color.gray)
                
                Spacer().frame(height: 60)
                
                Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(viewModel.statusText)
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(viewModel.statusTextColor)
                    .padding()
            }
            .navigationTitle("Barcode Scanner")
            .alert(item: $viewModel.alertItems) { item in
                Alert(
                    title: Text(item.title),
                    message: Text(item.message),
                    dismissButton: item.dismissButton)
            }
        }
    }
}

#Preview {
    BarcodeScannerView()
}
