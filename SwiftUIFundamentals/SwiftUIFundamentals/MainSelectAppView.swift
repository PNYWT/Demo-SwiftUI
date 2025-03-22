//
//  MainSelectAppView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 12/3/2568 BE.
//

import SwiftUI

struct MainSelectAppView: View {
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8.0) {
                NavigationLink(destination: WeatherContentView()) {
                    Text("App 1 - Weather")
                        .modifier(MainSelectButtonStyle())
                }
                
                NavigationLink(destination: AppleFrameWorkGridView()) {
                    Text("App 2 - App FrameWorks Grid")
                        .modifier(MainSelectButtonStyle())
                }
                
                NavigationLink(destination: AppleFrameWorkListView()) {
                    Text("App 2 - App FrameWorks List")
                        .modifier(MainSelectButtonStyle())
                }
                
                NavigationLink(destination: BarcodeScannerView()) {
                    Text("App 3 - BarcodeScaner")
                        .modifier(MainSelectButtonStyle())
                }
                NavigationLink {
                    AppetizerTabView()
                } label: {
                    Text("App 4 - Appetizers")
                        .modifier(MainSelectButtonStyle())
                }
            }
            .navigationTitle("📱 Select App")
            .frame(width: 300)
            .padding()
            .background(Color.red)
            .cornerRadius(16)
            .shadow(color: .red.opacity(0.5), radius: 12, x: 10, y: 5)
        }
    }
}

#Preview {
    MainSelectAppView()
}

struct MainSelectButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(16)
    }
}
