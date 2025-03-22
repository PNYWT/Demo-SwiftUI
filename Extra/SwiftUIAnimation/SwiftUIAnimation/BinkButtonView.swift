//
//  BinkButtonView.swift
//  SwiftUIAnimation
//
//  Created by CallmeOni on 13/3/2568 BE.
//

import SwiftUI

struct BinkButtonView: View {
    
    @State private var isLiked = false
    
    var body: some View {
        Button {
            isLiked.toggle()
        } label: {
            ZStack {
                image(Image(systemName: "heart.fill"), show: isLiked)
                image(Image(systemName: "heart"), show: !isLiked)
            }
        }
    }
    
    func image(_ image: Image, show: Bool) -> some View {
        image
            .tint(isLiked ? .red : .black)
            .font(.system(size: 60))
            .scaleEffect(show ? 1 : 0)
            .opacity(show ? 1 : 0)
            .animation(
                .interpolatingSpring(stiffness: 170, damping: 15), value: show)
    }
}

#Preview {
    BinkButtonView()
}
