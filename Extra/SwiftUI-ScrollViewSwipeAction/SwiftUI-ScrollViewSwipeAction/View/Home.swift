//
//  Home.swift
//  SwiftUI-ScrollViewSwipeAction
//
//  Created by CallmeOni on 30/3/2568 BE.
//

import SwiftUI

struct Home: View {
    
    @State private var colors: [Color] = [.black, .yellow, .purple, .brown]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 8) {
                ForEach(colors, id: \.self) { color in
                    SwipeActionView(conrnerRadius: 16, direction: .trailing) {
                        CardView(color: color)
                           
                    } actions: {
                        ActionModel(tint: .red, icon: "trash.fill") {
                            print("Delete Row")
                            withAnimation(.easeInOut) {
                                colors.removeAll { item in
                                    return item == color
                                }
                            }
                        }
                        
                        ActionModel(tint: .blue, icon: "pencil", isEnabled: color == .black) {
                            print("Edited")
                        }
                    } 
                }
            }
            .padding(.horizontal, 8)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ContentView()
}
