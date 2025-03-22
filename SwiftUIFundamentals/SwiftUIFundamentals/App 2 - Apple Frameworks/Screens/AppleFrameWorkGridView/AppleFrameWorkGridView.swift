//
//  AppleFrameWorkGridView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 8/3/2568 BE.
//

import SwiftUI

struct AppleFrameWorkGridView: View {
    
    @StateObject var viewModel = AppleFrameWorkGridViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: viewModel.columns) {
                    ForEach(MockData.frameworks) { modelFrameWork in VFrameworkTitleView(frameworkModel: modelFrameWork)
                            .onTapGesture {
                                viewModel.selectedFramework = modelFrameWork
                            }
                    }
                }
            }
            .navigationTitle("🍎 Frameworks")
            .sheet(isPresented: $viewModel.isShowingDetailView) {
                FrameworkDetailView(
                    frameworkDetailViewModel: FrameworkDetailViewModel(
                        frameworkModel: viewModel.selectedFramework ?? MockData.sampleFramework,
                        isShowingDetailView: $viewModel.isShowingDetailView),
                    isVStack: true)
            }
        }
    }
}

#Preview {
    AppleFrameWorkGridView().preferredColorScheme(.dark)
}
