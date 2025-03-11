//
//  PrimaryXButton.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 11/3/2568 BE.
//

import SwiftUI

struct PrimaryXButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundStyle(Color.white)
                .opacity(0.7)
            Image(systemName: "xmark")
                .imageScale(.medium)
                .frame(width: 44, height: 44)
                .foregroundStyle(Color.black)
        }
    }
}

#Preview {
    PrimaryXButton()
}
