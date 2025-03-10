//
//  AppetizerListView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import SwiftUI
import Combine

struct AppetizerListView: View {
    
    @StateObject var appetizerListViewModel = AppetizerListViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                List(appetizerListViewModel.appetizers) { item in
                    AppetizerListCell(appetizer: item)
                }
                .listStyle(.plain)
                .navigationTitle(Text("🍎 Appertizer"))
            }
            .onAppear {
                appetizerListViewModel.getAppetizers()
            }
            if appetizerListViewModel.isLoading {
                LoadingView()
            }
        }
        .alert(item: $appetizerListViewModel.alertItemNetwork) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    AppetizerListView()
}
