//
//  AppetizerTabView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import SwiftUI

struct AppetizerTabView: View {
    
    @StateObject var tabbarItemsViewModel = TabbarItemsViewModel()
    
    var body: some View {
        TabView {
            ForEach(tabbarItemsViewModel.itemsTabbar, id: \.self) { tab in
                tabbarItemsViewModel.view(for: tab)
                    .tabItem { Label(tab.title, systemImage: tab.iconName) }
            }
        }

       /*
        ZStack(alignment: .bottom) {
            TabView(selection: $tabbarItemsViewModel.selectedTab) {
                ForEach(tabbarItemsViewModel.itemsTabbar, id: \.self) { tab in
                    tabbarItemsViewModel.view(for: tab)
                        .tag(tab)
                }
            }
            customTabBar
        }
        */
    }
    
    var customTabBar: some View {
        ZStack {
            HStack {
                ForEach(tabbarItemsViewModel.itemsTabbar, id: \.self) { item in
                    Button {
                        tabbarItemsViewModel.selectedTab = item
                    } label: {
                        CustomTabItem(imageName: item.iconName, title: item.title, isActive: (tabbarItemsViewModel.selectedTab == item))
                    }
                }
            }
            .padding(6)
        }
        .frame(height: 70)
        .background(.purple.opacity(0.2))
        .cornerRadius(36)
        .padding(.horizontal, 26)
    }
}

extension AppetizerTabView {
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            if isActive {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? 120 : 60, height: 60)
        .background(isActive ? .purple.opacity(0.4) : .clear)
        .cornerRadius(30)
    }
}

#Preview {
    AppetizerTabView()
}
