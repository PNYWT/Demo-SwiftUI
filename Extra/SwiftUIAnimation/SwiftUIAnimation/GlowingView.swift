//
//  GlowingView.swift
//  SwiftUIAnimation
//
//  Created by CallmeOni on 13/3/2568 BE.
//

import SwiftUI

struct GlowingView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Circle()
                    .frame(height: 100)
                    .foregroundStyle(.yellow)
                    .modifier(Glow())
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.blue)
                    .frame(width: 100, height: 100)
                    .modifier(Glow())
                
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
                    .font(.system(size: 100))
                    .modifier(Glow())
                
            }
        }
    }
}

struct Glow: ViewModifier {
    
    @State private var throb = false
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: throb ? 25 : 5)
                .animation(.easeOut(duration: 1.0).repeatForever(), value: throb)
                .onAppear {
                    throb.toggle()
                }
            content
        }
    }
}

#Preview {
    GlowingView()
}
