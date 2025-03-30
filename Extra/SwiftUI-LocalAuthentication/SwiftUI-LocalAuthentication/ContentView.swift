//
//  ContentView.swift
//  SwiftUI-LocalAuthentication
//
//  Created by CallmeOni on 30/3/2568 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LockView(lockType: .biometric, lockPin: "0000", isEnabled: true) {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                
                Text("Hello")
            }
        }
    }
}

#Preview {
    ContentView()
}
