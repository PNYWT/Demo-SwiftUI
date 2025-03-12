//
//  AppleFrameWorkListView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 9/3/2568 BE.
//

import SwiftUI

struct AppleFrameWorkListView: View {
    
    @StateObject var viewModel = AppleFrameWorkGridViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(MockData.frameworks) { modelFrameWork in
                    NavigationLink(value: modelFrameWork) {
                        HFrameworkTitleView(frameworkModel: modelFrameWork)
                    }
                }
            }
            .navigationTitle("🍎 Frameworks")
            .navigationDestination(for: FrameworkModel.self) { frameworkModel in
                FrameworkDetailView(
                    frameworkDetailViewModel: FrameworkDetailViewModel(
                        frameworkModel: viewModel.selectedFramework ?? MockData.sampleFramework,
                        isShowingDetailView: $viewModel.isShowingDetailView),
                    isVStack: false)
            }
        }
        .accentColor(Color(.label))
    }
}

#Preview {
    AppleFrameWorkListView().preferredColorScheme(.dark)
}
