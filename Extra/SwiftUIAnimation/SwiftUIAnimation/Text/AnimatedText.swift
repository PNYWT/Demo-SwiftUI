//
//  AnimatedText.swift
//  SwiftUIAnimation
//
//  Created by CallmeOni on 13/3/2568 BE.
//

import SwiftUI

struct AnimatedText: View {
    @State private var moveGradient = true
    var body: some View {
        GeometryReader { geo in
            let widthFrame = geo.size.width
            Rectangle()
                .overlay {
                    LinearGradient(colors: [.clear, .white, .clear], startPoint: .leading, endPoint: .trailing)
                        .frame(width: widthFrame / 2)
                        .offset(x: moveGradient ?  -widthFrame / 2 : widthFrame / 2)
                }
                .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: moveGradient)
                .mask {
                    Text("Slide to power off")
                        .foregroundStyle(.black)
                        .font(.largeTitle)
                }
                .onAppear {
                    moveGradient.toggle()
                }
                .background(.gray)
        }
    }
}

#Preview {
    AnimatedText()
}
