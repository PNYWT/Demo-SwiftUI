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
                        .listRowSeparator(.hidden)
//                        .listRowSeparatorTint(.darkGreen)
                        .onTapGesture {
                            appetizerListViewModel.isShowingDetail = true
                            appetizerListViewModel.selectedAppetizer = item
                        }
                }
                .navigationTitle(Text("🍎 Appertizer"))
                .listStyle(.plain)
                .disabled(appetizerListViewModel.isShowingDetail)
            }
            .task {
                await appetizerListViewModel.getAppetizers()
            }
            .blur(radius: appetizerListViewModel.isShowingDetail ? 20 : 0.0)
            
            if appetizerListViewModel.isShowingDetail {
                AppertizerDetailView(appertizer: appetizerListViewModel.selectedAppetizer!, isShowingDetail: $appetizerListViewModel.isShowingDetail)
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
