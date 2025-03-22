//
//  PrimaryCartButton.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 11/3/2568 BE.
//

import SwiftUI

struct PrimaryCartButton: View {
    
    let price: Double
    let title: String
    
    var body: some View {
        Text("$\(price, specifier: "%.2f") - \(title)")
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 260, height: 50)
            .foregroundStyle(.white)
            .background(Color.darkGreen)
            .cornerRadius(8)
    }
}

#Preview {
    PrimaryCartButton(price: 99.0, title: "Add to Order")
}
