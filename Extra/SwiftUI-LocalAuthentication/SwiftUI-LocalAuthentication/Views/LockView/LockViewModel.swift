//
//  LockViewModel.swift
//  SwiftUI-LocalAuthentication
//
//  Created by CallmeOni on 31/3/2568 BE.
//

import SwiftUI
import LocalAuthentication

enum LockType: String {
    case biometric = "Bio Metric Auth"
    case number = "Custom Number Lock"
    case both = "First preference will be biometric, and if it's not avaliable, it will go for number lock."
}

class LockViewModel: ObservableObject {
    
    @AppStorage("pinUser") var lockPin: String = ""
    var pinInit: String = ""
    var confirmPin: String = ""
    
    var isEnabled: Bool // Enable Lock
    var lockWhenAppGoesBackground: Bool = true
    var lockType: LockType
    
    @Published var isConfirmPin: Bool = false
    @Published var pinInput: String = ""
    @Published var isUnlocked: Bool = false
    @Published var noBiometricAccess: Bool = false
    @Published var needPad = false
    @Published var animateField: Bool = false
    
    let context = LAContext()
    var isBiometricAvailable: Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    init(lockType: LockType,
         isEnabled: Bool) {
        self.lockType = lockType
        self.isEnabled = isEnabled
    }
    
    func unlockWithFaceID() {
        Task { @MainActor in
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
            
            /// Fail เปิด Keypad
            noBiometricAccess = !isBiometricAvailable
            needPad = true
        }
    }
}

// MARK: Check Input Pin
extension LockViewModel {
    
    func handlePinInput(newValue: String) {
        guard newValue.count == 4 else { return }
        switch lockPin.isEmpty {
        case true:
            if !isConfirmPin {
                withAnimation(.snappy, completionCriteria: .logicallyComplete) {
                    isConfirmPin = true
                } completion: { [self] in
                    pinInit = pinInput
                    pinInput.removeAll()
                }
            } else {
                confirmPin = pinInput
                if checkPinMatch() {
                    isConfirmPin = false
                } else {
                    withAnimation(.easeOut(duration: 0.5)) {
                        animateField.toggle()
                        pinInput.removeAll()
                    }
                }
            }
        case false:
            if lockPin == pinInput {
                withAnimation(.snappy, completionCriteria: .logicallyComplete) {
                    isUnlocked = true
                } completion: { [self] in
                    pinInput.removeAll()
                    noBiometricAccess = !isBiometricAvailable
                }
            } else {
                withAnimation(.easeOut(duration: 0.5)) {
                    animateField.toggle()
                    pinInput.removeAll()
                }
            }
        }
    }
    
    private func checkPinMatch() -> Bool {
        if pinInit == confirmPin {
            lockPin = confirmPin
            pinInput.removeAll()
        }
        return pinInit == confirmPin
    }
}


// MARK: Check Condition
extension LockViewModel {
    
    /// Show FaceID
    func conditionShowFaceID() -> Bool {
        return (lockType == .both && !noBiometricAccess) || lockType == .biometric
    }
    
    /// Check show Back button
    func conditionShowBackButton() -> Bool {
        return (lockType == .both && isBiometricAvailable) || isConfirmPin
    }
    
    
    /// Check action when tab back
    func checkActionback() {
        if lockPin.isEmpty {
            isConfirmPin = false
            pinInput.removeAll()
        } else {
            pinInput.removeAll()
            noBiometricAccess = false
            needPad = false
        }
    }
}

#Preview {
    ContentView()
}
