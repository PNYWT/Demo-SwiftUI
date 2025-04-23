//
//  NumberPadPinView.swift
//  SwiftUI-LocalAuthentication
//
//  Created by CallmeOni on 30/3/2568 BE.
//

import SwiftUI

struct NumberPadPinView: View {
    
    @ObservedObject private var lockViewModel: LockViewModel
    private var forgotPin: (() -> Void)?
    
    init(lockViewModel: LockViewModel,
         confirmPin: Bool = false,
         forgotPin: (() -> Void)? = nil) {
        self.lockViewModel = lockViewModel
        self.forgotPin = forgotPin
    }

    var body: some View {
        Rectangle()
            .fill(.black)
            .ignoresSafeArea()
        VStack(spacing: 16) {
            Text(lockViewModel.isConfirmPin ? "Confirm Pin" : "Enter Pin")
                .font(.title.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    if lockViewModel.conditionShowBackButton() {
                        Button {
                            lockViewModel.checkActionback()
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
                                if lockViewModel.pinInput.count < 4 {
                                    lockViewModel.pinInput.append("\(number)")
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
                                if lockViewModel.pinInput.count < 4 {
                                    lockViewModel.pinInput.append("\(0)")
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
                                if !lockViewModel.pinInput.isEmpty {
                                    lockViewModel.pinInput.removeLast()
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
            .onChange(of: lockViewModel.pinInput) { oldValue, newValue in
                lockViewModel.handlePinInput(newValue: newValue)
            }
        }
        .padding()
        .environment(\.colorScheme, .dark)
        .onAppear {
            lockViewModel.pinInput.removeAll()
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
                                if lockViewModel.pinInput.count > index {
                                    let index = lockViewModel.pinInput.index(lockViewModel.pinInput.startIndex, offsetBy: index)
                                    let starting = String(lockViewModel.pinInput[index])
                                    
                                    Text(starting)
                                        .font(.title.bold())
                                        .foregroundStyle(.black)
                                }
                            }
                    }
                }
                .keyframeAnimator(initialValue: CGFloat.zero, trigger: lockViewModel.animateField) { content, value in
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

                if !lockViewModel.lockPin.isEmpty {
                    Button {
                        forgotPin?()
                    } label: {
                        Text("Forgot Pin")
                            .font(.callout)
                            .foregroundStyle(.white)
                    }
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
