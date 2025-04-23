//
//  FaceIDView.swift
//  SwiftUI-LocalAuthentication
//
//  Created by CallmeOni on 2/4/2568 BE.
//

import SwiftUI

struct FaceIDView: View {
    
    @ObservedObject private var lockViewModel: LockViewModel
    
    init(lockViewModel: LockViewModel) {
        self.lockViewModel = lockViewModel
    }
    
    var body: some View {
        Rectangle()
            .fill(.black)
            .ignoresSafeArea()
        Group {
            if lockViewModel.needPad {
                NumberPadPinView(lockViewModel: lockViewModel) {
                    
                }
            } else {
                if lockViewModel.noBiometricAccess {
                    Text("Enable biometric authetication in Settings to unlock the view.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .padding(50)
                } else {
                    VStack(spacing: 16) {
                        Button {
                            lockViewModel.unlockWithFaceID()
                        } label: {
                            VStack(spacing: 8) {
                                Image(systemName: "lock")
                                    .font(.largeTitle)
                                Text("Tap to Unlock")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .frame(width: 100, height: 100)
                        .background(.ultraThinMaterial, in: .rect(cornerRadius: 8))
                        if lockViewModel.lockType == .both {
                            Button {
                                lockViewModel.noBiometricAccess = true
                            } label: {
                                Text("Enter Pin")
                                    .frame(width: 100, height: 40)
                                    .background(.ultraThinMaterial, in: .rect(cornerRadius: 8))
                                
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
