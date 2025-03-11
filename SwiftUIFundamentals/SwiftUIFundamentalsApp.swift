//
//  SwiftUIFundamentalsApp.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 1/3/2568 BE.
//

import SwiftUI

@main
struct SwiftUIFundamentalsApp: App {
    
    var orderViewModel = OrderViewModel()
    
    var body: some Scene {
        WindowGroup {
//            WeatherContentView()
//            AppleFrameWorkGridView()
//            AppleFrameWorkListView()
//            BarcodeScannerView()
            AppetizerTabView().environmentObject(orderViewModel)
        }
    }
}
