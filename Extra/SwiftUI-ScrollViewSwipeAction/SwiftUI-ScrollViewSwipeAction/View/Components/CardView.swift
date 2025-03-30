//
//  CardView.swift
//  SwiftUI-ScrollViewSwipeAction
//
//  Created by CallmeOni on 30/3/2568 BE.
//

import SwiftUI

struct CardView: View {
    
    private var color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 80, height: 8)
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 60, height: 8)
            }
            
            Spacer()
        }
        .foregroundStyle(.black.opacity(0.4))
        .padding([.horizontal, .vertical], 16)
        .background(color.gradient)
    }
}

#Preview {
    CardView(color: .red)
}
