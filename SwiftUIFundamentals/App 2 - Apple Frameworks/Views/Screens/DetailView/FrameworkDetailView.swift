//
//  FrameworkDetailView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 8/3/2568 BE.
//

import SwiftUI

struct FrameworkDetailView: View {
    
    var frameworkModel: FrameworkModel
    var isVStack: Bool = true
    @Binding var isShowingDetailView: Bool
    @State private var isShowingSafariView: Bool = false
    
    var body: some View {
        VStack {
            if isVStack {
                PrimaryXButtonView(isShowingDetailView: $isShowingDetailView)
            }
            
            Spacer()
            
            VFrameworkTitleView(frameworkModel: frameworkModel)
            
            Text(frameworkModel.description)
                .font(.body)
                .padding(.horizontal, 16)
            
            Spacer()
            
            Button {
                isShowingSafariView = true
            } label: {
                PrimaryButtonView(imageSystemName: "book", titleButton: "Learn More")
            }

        }
        .fullScreenCover(isPresented: $isShowingSafariView) {
            SafariView(url: URL(string: frameworkModel.urlString) ?? URL(string: "www.apple.com")!)
        }
    }
}

#Preview {
    FrameworkDetailView(frameworkModel: MockData.sampleFramework, isShowingDetailView: .constant(false)).preferredColorScheme(.dark)
}
