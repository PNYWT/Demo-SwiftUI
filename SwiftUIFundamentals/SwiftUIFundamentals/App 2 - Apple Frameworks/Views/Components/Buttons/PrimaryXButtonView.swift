//
//  PrimaryXButtonView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 9/3/2568 BE.
//

import SwiftUI

struct PrimaryXButtonView: View {
    
    @Binding var isShowingDetailView: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                isShowingDetailView = false
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(Color(.label))
                    .imageScale(.large)
                    .frame(width: 44, height: 44)
            }
        }
        .padding()
    }
}

#Preview {
    PrimaryXButtonView(isShowingDetailView: .constant(false))
}
