//
//  LockView.swift
//  SwiftUI-LocalAuthentication
//
//  Created by CallmeOni on 30/3/2568 BE.
//

import SwiftUI
import LocalAuthentication

enum LockType: String {
    case biometric = "Bio Metric Auth"
    case number = "Custom Number Lock"
    case both = "First preference will be biometric, and if it's not avaliable, it will go for number lock."
}

struct LockView<Content: View>: View {
    
    private var isEnabled: Bool // Enable Lock
    private var lockWhenAppGoesBackground: Bool = true
    private var lockType: LockType
    private var lockPin: String // User Pin
    private var content: Content
    
    @State private var isUnlocked: Bool = false
    @State private var noBiometricAccess: Bool = false
    let context = LAContext()
    
    @Environment(\.scenePhase) private var phase
    
    
    init(lockType: LockType,
         lockPin: String,
         isEnabled: Bool,
         @ViewBuilder content:() -> Content) {
        self.lockType = lockType
        self.lockPin = lockPin
        self.isEnabled = isEnabled
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometryProxy in
            let size = geometryProxy.size
            
            content
                .frame(width: size.width, height: size.height)
            
            if isEnabled && !isUnlocked {
                ZStack {
                    if (lockType == .both && !noBiometricAccess) || lockType == .biometric {
                        Rectangle()
                            .fill(.black)
                            .ignoresSafeArea()
                        Group {
                            if noBiometricAccess {
                                Text("Enable biometric authetication in Settings to unlock the view.")
                                    .font(.callout)
                                    .multilineTextAlignment(.center)
                                    .padding(50)
                            } else {
                                VStack(spacing: 16) {
                                    VStack(spacing: 8) {
                                        Image(systemName: "lock")
                                            .font(.largeTitle)
                                        
                                        Text("Tap to Unlock")
                                            .font(.caption2)
                                            .foregroundStyle(.gray)
                                    }
                                    .frame(width: 100, height: 100)
                                    .background(.ultraThinMaterial, in: .rect(cornerRadius: 8))
                                    .onTapGesture {
                                        unlockView()
                                    }
                                    
                                    if lockType == .both {
                                        Text("Enter Pin")
                                            .frame(width: 100, height: 40)
                                            .background(.ultraThinMaterial, in: .rect(cornerRadius: 8))
                                            .onTapGesture {
                                                noBiometricAccess = true
                                            }
                                    }
                                }
                            }
                        }
                    } else {
                        NumberPadPinView(
                            lockType: lockType,
                            lockPin: lockPin,
                            isBiometricAvailable: isBiometricAvailable,
                            isUnlocked: $isUnlocked,
                            noBiometricAccess: $noBiometricAccess) {
                            
                        }
                        
                    }
                }
                .environment(\.colorScheme, .dark)
                .transition(.offset(y: size.height + 100))
            }
        }
        .onChange(of: isEnabled, initial: true) { oldValue, newValue in
            if newValue {
                unlockView()
            }
        }
        .onChange(of: phase) { oldValue, newValue in
            if newValue != .active && lockWhenAppGoesBackground {
                isUnlocked = false
            }
        }
    }
    
    private func unlockView() {
        Task {
            if isBiometricAvailable && lockType != .number {
                if let result = try? await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock the View"), result {
                    print("Unlocked")
                    withAnimation(.snappy, completionCriteria: .logicallyComplete) {
                        isUnlocked = true
                    } completion: {
                        return
                    }
                }
            }
            
            /// No bio metric premission || Lock type must be set as keypad
            noBiometricAccess = !isBiometricAvailable
        }
    }
    
    private var isBiometricAvailable: Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
}

#Preview {
    ContentView()
}
