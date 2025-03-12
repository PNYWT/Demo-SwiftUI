//
//  FrameworkDetailViewModel.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 12/3/2568 BE.
//

import SwiftUI

final class FrameworkDetailViewModel: ObservableObject {
    
    let frameworkModel: FrameworkModel
    var isShowingDetailView: Binding<Bool>
    @Published var isShowingSafariView: Bool = false
    
    init(frameworkModel: FrameworkModel, isShowingDetailView: Binding<Bool>) {
        self.frameworkModel = frameworkModel
        self.isShowingDetailView = isShowingDetailView
    }
}
