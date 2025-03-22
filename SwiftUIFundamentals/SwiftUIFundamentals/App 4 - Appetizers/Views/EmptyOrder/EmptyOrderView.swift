//
//  EmptyOrderView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 12/3/2568 BE.
//

import SwiftUI

struct EmptyOrderView: View {
    
    let imageName: UIImage
    let message: String
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            VStack {
                Image(uiImage: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                
                Text(message)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding()
            }
            .offset(y: -25)
        }
    }
}

#Preview {
    EmptyOrderView(imageName: .emptyOrder, message: "Default Message")
}
