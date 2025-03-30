//
//  NumberPadPinView.swift
//  SwiftUI-LocalAuthentication
//
//  Created by CallmeOni on 30/3/2568 BE.
//

import SwiftUI

struct NumberPadPinView: View {
    
    @State private var pin: String = ""
    private var lockPin: String
    private var forgotPin: () -> Void
    
    @State private var animateField: Bool = false
    @Binding private var isUnlocked: Bool
    @Binding private var noBiometricAccess: Bool
    private var lockType: LockType
    private var isBiometricAvailable: Bool
    
    init(lockType: LockType,
         lockPin: String,
         isBiometricAvailable: Bool,
         isUnlocked: Binding<Bool>,
         noBiometricAccess: Binding<Bool>,
         forgotPin: @escaping () -> Void) {
        self.lockPin = lockPin
        self.lockType = lockType
        self.isBiometricAvailable = isBiometricAvailable
        self._noBiometricAccess = noBiometricAccess
        self._isUnlocked = isUnlocked
        self.forgotPin = forgotPin
    }
    
    var body: some View {
        Rectangle()
            .fill(.black)
            .ignoresSafeArea()
        VStack(spacing: 16) {
            Text("Enter Pin")
                .font(.title.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    if lockType == .both && isBiometricAvailable {
                        Button {
                            pin.removeAll()
                            noBiometricAccess = false
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title3)
                                .contentShape(.rect)
                        }
                        .tint(.white)
                        .padding(.leading)
                    }
                }
            
            enterPinView()
            
            GeometryReader { geometryProxy in
                LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                    ForEach(1...12, id: \.self) { number in
                        
                        if (1...9).contains(number) {
                            Button {
                                if pin.count < 4 {
                                    pin.append("\(number)")
                                }
                            } label: {
                                Text("\(number)")
                                    .font(.title)
                                    .frame(maxHeight: .infinity)
                                    .padding(.vertical, 20)
                                    .contentShape(.rect)
                            }
                            .tint(.white)
                        } else if number == 10 {
                            Rectangle()
                                .fill(Color.clear)
                        } else if number == 11 {
                            Button {
                                if pin.count < 4 {
                                    pin.append("\(0)")
                                }
                            } label: {
                                Text("0")
                                    .font(.title)
                                    .frame(maxHeight: .infinity)
                                    .padding(.vertical, 20)
                                    .contentShape(.rect)
                            }
                            .tint(.white)
                        } else {
                            Button {
                                if !pin.isEmpty {
                                    pin.removeLast()
                                }
                            } label: {
                                Image(systemName: "delete.backward")
                                    .font(.title)
                                    .frame(maxHeight: .infinity)
                                    .padding(.vertical, 20)
                                    .contentShape(.rect)
                            }
                            .tint(.white)
                        }
                    }
                }
            }
            .onChange(of: pin) { oldValue, newValue in
                if newValue.count == 4 {
                    if lockPin == pin {
                        print("Unlock")
                        withAnimation(.snappy, completionCriteria: .logicallyComplete) {
                            isUnlocked = true
                        } completion: {
                            pin.removeAll()
                            noBiometricAccess = !isBiometricAvailable
                        }
                    } else {
                        print("Wrong Pin")
                        withAnimation(.easeOut(duration: 0.5)) {
                            animateField.toggle()
                            pin.removeAll()
                        }
                    }
                }
            }
        }
        .padding()
        .environment(\.colorScheme, .dark)
        .onAppear {
            pin.removeAll()
        }
    }
    
    private func enterPinView() -> some View {
        ZStack {
            VStack(spacing: 16) {
                HStack(spacing: 8) {
                    ForEach(0..<4, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 50, height: 55)
                            .overlay {
                                if pin.count > index {
                                    let index = pin.index(pin.startIndex, offsetBy: index)
                                    let starting = String(pin[index])
                                    
                                    Text(starting)
                                        .font(.title.bold())
                                        .foregroundStyle(.black)
                                }
                            }
                    }
                }
                .keyframeAnimator(initialValue: CGFloat.zero, trigger: animateField) { content, value in
                    content
                        .offset(x: value)
                } keyframes: { _ in
                    KeyframeTrack {
                        CubicKeyframe(15, duration: 0.07)
                        CubicKeyframe(-15, duration: 0.07)
                        CubicKeyframe(10, duration: 0.07)
                        CubicKeyframe(-10, duration: 0.07)
                        CubicKeyframe(0, duration: 0.07)
                    }
                }

                Button {
                    forgotPin()
                } label: {
                    Text("Forgot Pin")
                        .font(.callout)
                        .foregroundStyle(.white)
                }
            }
            .padding(.top, 16)
            .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
