//
//  PrimaryButtonStyleView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 7/3/2568 BE.
//

import SwiftUI

/*
 Use All app
 */
struct PrimaryButtonStyleView: View {
    
    var textTitle: String
    var textColor: Color
    var backgroundColor: Color
    
    var tapAction: () -> Void
    
    var body: some View {
        Button {
            print("Tapped")
            tapAction()
        } label: {
            Text(textTitle)
                .padding(.all, 16.0)
                .frame(width: 250, height: 50)
                .foregroundColor(textColor)
                .background(backgroundColor.gradient)
                .cornerRadius(50 / 2)
                .font(.system(size: 20, weight: .bold))
                .fixedSize()
        }
    }
}

#Preview {
    PrimaryButtonStyleView(textTitle: "Hello", textColor: .white, backgroundColor: .blue, tapAction: {
        return
    })
}

