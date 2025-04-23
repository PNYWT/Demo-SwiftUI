//
//  LockView.swift
//  SwiftUI-LocalAuthentication
//
//  Created by CallmeOni on 30/3/2568 BE.
//

import SwiftUI
import LocalAuthentication


struct LockView<Content: View>: View {
    
    @ObservedObject private var lockViewModel: LockViewModel
    private var content: Content
    @Environment(\.scenePhase) private var phase
    
    init(lockViewModel: LockViewModel,
         @ViewBuilder content:() -> Content) {
        self.lockViewModel = lockViewModel
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometryProxy in
            let size = geometryProxy.size
            content
                .frame(width: size.width, height: size.height)
                
            if lockViewModel.isEnabled && !lockViewModel.isUnlocked {
                checkLockTypeView(size: size)
            }
        }
        .onChange(of: lockViewModel.isEnabled, initial: true) { oldValue, newValue in
            if newValue {
                lockViewModel.unlockWithFaceID()
            }
        }
        .onChange(of: phase) { oldValue, newValue in
            if newValue != .active && lockViewModel.lockWhenAppGoesBackground {
                lockViewModel.isUnlocked = false
            }
        }
    }
    
    private func checkLockTypeView(size: CGSize) -> some View {
        ZStack {
            if lockViewModel.conditionShowFaceID() {
                FaceIDView(lockViewModel: lockViewModel)
            } else {
                NumberPadPinView(lockViewModel: lockViewModel) {
                    
                }
            }
        }
        .environment(\.colorScheme, .dark)
        .transition(.offset(y: size.height + 100))
    }
}

#Preview {
    ContentView()
}
