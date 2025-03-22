//
//  LoadingAnimationView.swift
//  SwiftUIAnimation
//
//  Created by CallmeOni on 13/3/2568 BE.
//

import SwiftUI

struct LoadingAnimationView: View {
    
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 4)
                .opacity(0.3)
                .foregroundStyle(.gray)
            
            Circle()
                .trim(from: 0, to: 0.25)
                .stroke(style: .init(lineWidth: 4.0, lineCap: .round, lineJoin: .round))
                .foregroundStyle(.red)
                .rotationEffect(.degrees(rotationAngle))
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: rotationAngle)
                .onAppear {
                    rotationAngle = 360
                }
            
            Text("Loading...")
        }
        .compositingGroup()
        .frame(width: 100)
    }
}

#Preview {
    LoadingAnimationView()
}
