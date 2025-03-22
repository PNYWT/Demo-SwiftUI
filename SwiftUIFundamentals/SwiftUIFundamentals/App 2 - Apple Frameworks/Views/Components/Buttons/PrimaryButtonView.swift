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
    var backgroundColor: Color? = .red
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: imageSystemName)
                .foregroundStyle(.white)
            Text(titleButton)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Spacer()
        }
//        .frame(width: 200, height: 50)
        .frame(minWidth: 150, maxWidth: 200, maxHeight: 50)
        .background(backgroundColor)
        .cornerRadius(25)
    }
}

#Preview {
    PrimaryButtonView(imageSystemName: "book", titleButton: "Learn More")
}
