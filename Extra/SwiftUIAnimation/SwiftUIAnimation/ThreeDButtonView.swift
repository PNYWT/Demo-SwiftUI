//
//  ThreeDButtonView.swift
//  SwiftUIAnimation
//
//  Created by CallmeOni on 13/3/2568 BE.
//

import SwiftUI

struct ThreeDButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            let offset: CGFloat = 8
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.purple.opacity(0.4))
                .offset(y: offset)
            
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.purple)
                .offset(y: configuration.isPressed ? offset : 0)
            
            // text title button
            configuration.label
                .offset(y: configuration.isPressed ? offset : 0)
        }
        .compositingGroup()
        .shadow(color: .purple, radius: 8, y: 8)
    }
}

#Preview {
    Button("Button") {
        
    }
    .foregroundStyle(.white)
    .frame(width: 150, height: 50)
    .buttonStyle(ThreeDButtonStyle())
}
