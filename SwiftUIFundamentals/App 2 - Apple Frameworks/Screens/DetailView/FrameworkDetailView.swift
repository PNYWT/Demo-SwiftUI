//
//  FrameworkDetailView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 8/3/2568 BE.
//

import SwiftUI

struct FrameworkDetailView: View {
    
    @ObservedObject var frameworkDetailViewModel: FrameworkDetailViewModel
    private var isVStack: Bool = true
    
    init(frameworkDetailViewModel: FrameworkDetailViewModel, isVStack: Bool) {
        self.frameworkDetailViewModel = frameworkDetailViewModel
        self.isVStack = isVStack
    }
    
    var body: some View {
        VStack {
            if isVStack {
                PrimaryXButtonView(isShowingDetailView: $frameworkDetailViewModel.isShowingDetailView.wrappedValue)
            }
            
            Spacer()
            
            VFrameworkTitleView(frameworkModel: frameworkDetailViewModel.frameworkModel)
            
            Text(frameworkDetailViewModel.frameworkModel.description)
                .font(.body)
                .padding(.horizontal, 16)
            
            Spacer()
            
            HStack(spacing: 16) {
                Link(destination: URL(string: "https://www.google.co.th/search?q=\(frameworkDetailViewModel.frameworkModel.name)")!) {
                    PrimaryButtonView(
                        imageSystemName: "magnifyingglass",
                        titleButton: "Search More",
                        backgroundColor: .blue)
                }

                Button {
                    frameworkDetailViewModel.isShowingSafariView = true
                } label: {
                    PrimaryButtonView(
                        imageSystemName: "book",
                        titleButton: "Read Docs")
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .fullScreenCover(isPresented: $frameworkDetailViewModel.isShowingSafariView) {
            SafariView(url: URL(string: frameworkDetailViewModel.frameworkModel.urlString) ?? URL(string: "www.apple.com")!)
        }
    }
}

#Preview {
    FrameworkDetailView(
        frameworkDetailViewModel: FrameworkDetailViewModel(
         frameworkModel: MockData.sampleFramework,
         isShowingDetailView: .constant(false)), isVStack: true)
        .preferredColorScheme(.dark)
}
