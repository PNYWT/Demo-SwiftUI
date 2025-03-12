//
//  AppetizerTabView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import SwiftUI

struct AppetizerTabView: View {
    
    @EnvironmentObject var orderViewModel: OrderViewModel
    
    var body: some View {
        TabView {
            AppetizerListView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
            
            OrderView()
                .tabItem {
                    Label("Order", systemImage: "bag")
                }
                .badge(orderViewModel.items.count)
        }
        .accentColor(.darkGreen)

    
    }
}

#Preview {
    AppetizerTabView()
}
