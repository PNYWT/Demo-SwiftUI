//
//  ContentView.swift
//  SwiftUI-AlertError
//
//  Created by CallmeOni on 15/3/2568 BE.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingBasicAlert = false
    @State private var isShowingEnterValueAlert = false
    @State private var valueString = ""
    
    @State private var error: AppError?
    @State private var isShowingLoginAlert = false
    
    var body: some View {
        VStack(spacing: 40) {
            Button("Fetch Data") {
                isShowingBasicAlert = true
            }
            .alert("No Network Connection", isPresented: $isShowingBasicAlert) {
                Button("Try Again") {
                    
                }
                
                Button("Cancel", role: .cancel) {
                    
                }
                
                /*
                 Button("Delete", role
                        : .destructive) {
                     
                 }
                 */
            } message: {
                Text("No network detected. Connect to wi-fi or celluar data to continue.")
            }
            
            Button("Enter Data") {
                isShowingEnterValueAlert = true
            }
            .alert("Enter Value", isPresented: $isShowingEnterValueAlert) {
                TextField("Value", text: $valueString)
                
                Button("Summit") {
                    
                }
                
                Button("Cancel", role: .cancel) {
                    
                }
            } message: {
                Text("Enter the dollar value of your.")
            }
            
            Button("Log In") {
                if valueString.isEmpty {
                    error = .invalidUserName
                }
                isShowingLoginAlert = true
            }
            .alert(isPresented: $isShowingLoginAlert, error: error) { error in
                if error == .invalidUserName {
                    TextField("Value", text: $valueString)
                    
                    Button("Summit") {
                        
                    }
                    
                    Button("Cancel", role: .cancel) {
                        
                    }
                }
            } message: { error in
                Text(error.failureReason)
            }

        }
    }
}

#Preview {
    ContentView()
}
