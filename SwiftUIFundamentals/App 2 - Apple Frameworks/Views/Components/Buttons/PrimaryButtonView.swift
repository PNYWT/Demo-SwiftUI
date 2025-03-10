//
//  PrimaryButtonView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 8/3/2568 BE.
//

import SwiftUI

struct PrimaryButtonView: View {
    
    var imageSystemName: String
    var titleButton: String
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: imageSystemName)
                .foregroundStyle(.white)
            Text(titleButton)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            Spacer()
        }
        .frame(width: 200, height: 50)
        .background(Color.red)
        .cornerRadius(25)
    }
}

#Preview {
    PrimaryButtonView(imageSystemName: "book", titleButton: "Learn More")
}
