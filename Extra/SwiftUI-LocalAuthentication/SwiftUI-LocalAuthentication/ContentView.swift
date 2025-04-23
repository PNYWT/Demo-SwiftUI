//
//  ContentView.swift
//  SwiftUI-LocalAuthentication
//
//  Created by CallmeOni on 30/3/2568 BE.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var lockViewModel: LockViewModel = LockViewModel(lockType: .number, isEnabled: true)
    
    init() {
        lockViewModel.lockPin = ""
    }
    
    var body: some View {
        ZStack {
            Group {
                switch lockViewModel.isUnlocked {
                case true:
                    LockView(lockViewModel: lockViewModel) {
                        VStack {
                            Image(systemName: "globe")
                                .imageScale(.large)
                            Text("Hello")
                        }
                    }
                case false:
                    NumberPadPinView(lockViewModel: lockViewModel)
                        .transition(.move(
                            edge: lockViewModel.isConfirmPin ? .trailing : .leading))
                }
            }
        }
        .animation(.easeInOut, value: lockViewModel.isConfirmPin)
    }
}

#Preview {
    ContentView()
}
