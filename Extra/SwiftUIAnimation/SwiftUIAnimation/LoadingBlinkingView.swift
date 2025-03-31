//
//  LoadingBlinkingView.swift
//  SwiftUIAnimation
//
//  Created by CallmeOni on 31/3/2568 BE.
//

import SwiftUI

struct LoadingBlinkingView: View {
    @State var isAnimating: Bool = false
    let count: Int
    let size: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<count, id: \.self) { index in
                item(forIndex: index, in: geometry.size)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .onAppear {
                isAnimating = true
            }
        }
        .aspectRatio(contentMode: .fit)
    }

    private func item(forIndex index: Int, in geometrySize: CGSize) -> some View {
        let angle = 2 * CGFloat.pi / CGFloat(count) * CGFloat(index)
        let x = (geometrySize.width / 2 - size / 2) * cos(angle)
        let y = (geometrySize.height / 2 - size / 2) * sin(angle)
        return Circle()
            .frame(width: size, height: size)
            .scaleEffect(isAnimating ? 0.5 : 1)
            .opacity(isAnimating ? 0.25 : 1)
            .animation(
                Animation
                    .default
                    .repeatCount(isAnimating ? .max : 1, autoreverses: true)
                    .delay(Double(index) / Double(count) / 2)
                , value: isAnimating)
            .offset(x: x, y: y)
    }
}

#Preview {
    LoadingBlinkingView(count: 8, size: 16)
}
