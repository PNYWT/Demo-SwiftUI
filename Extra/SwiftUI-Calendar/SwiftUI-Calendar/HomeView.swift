//
//  Home.swift
//  SwiftUI-Calendar
//
//  Created by CallmeOni on 22/3/2568 BE.
//

import SwiftUI

struct HomeView: View {
    
    @State var currentData: Date = Date()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 20) {
                CustomDateView(currentDate: $currentData)
            }
            .padding(.vertical)
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button {
                    
                } label: {
                    Text("Add Task")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                        .tint(.white)
                        .padding(.vertical)
                        .background(Color.orange, in: Capsule())
                        
                }
                
                Button {
                    
                } label: {
                    Text("Add Remainder")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                        .tint(.white)
                        .padding(.vertical)
                        .background(Color.purple, in: Capsule())
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .background(.ultraThinMaterial)
        }
    }
}

#Preview {
    HomeView()
}
