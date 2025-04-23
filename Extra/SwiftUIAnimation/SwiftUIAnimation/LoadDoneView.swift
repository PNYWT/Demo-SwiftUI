//
//  BinkButtonView.swift
//  SwiftUIAnimation
//
//  Created by CallmeOni on 13/3/2568 BE.
//


import SwiftUI

struct LoadDoneView: View {
    
    var status: Bool
    @State private var animate = false
    
    init(status: Bool) {
        self.status = status
    }

    var body: some View {
        GeometryReader { geometry in
            let sizeFrame = geometry.size
            ZStack {
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .stroke(status ? Color.green.opacity(0.3) : Color.red.opacity(0.3), lineWidth: 10)
                        
                        Image(systemName: status ? "checkmark" : "xmark")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(status ? .green : .red)
                            .scaleEffect(animate ? 1 : 0.3)
                            .opacity(animate ? 1 : 0)
                            .animation(.spring(response: 0.4, dampingFraction: 0.6).delay(0.2), value: animate)
                    }
                    
                    Text(status ? "Success!" : "Fail")
                        .font(.title3)
                        .bold()
                        .foregroundColor(status ? .green : .red)
                        .opacity(animate ? 1 : 0)
                        .offset(y: animate ? 0 : 20)
                        .animation(.easeOut.delay(0.4), value: animate)
                }
                .onAppear {
                    animate = true
                }
            }
            .frame(width: sizeFrame.width, height: sizeFrame.height)
            .padding(.vertical, 8.0)
        }
        .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    ZStack {
        Rectangle()
            .fill(Color.blue)
        LoadDoneView(status: false)
    }
    .frame(width: 100, height: 120)
}
