//
//  AppleFrameWorkGridViewModel.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 8/3/2568 BE.
//

import SwiftUI

final class AppleFrameWorkGridViewModel: ObservableObject {
    
    // data source
    var selectedFramework: FrameworkModel? {
        didSet { isShowingDetailView = true }
    }
    
    // view action
    @Published var isShowingDetailView = false
    
    // view style
    let columns: [GridItem] = [
        GridItem.init(.flexible()),
        GridItem.init(.flexible()),
        GridItem.init(.flexible())
    ]
}
