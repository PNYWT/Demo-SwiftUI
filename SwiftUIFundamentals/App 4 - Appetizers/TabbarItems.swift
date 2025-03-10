//
//  TabbarItems.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import SwiftUI

class TabbarItemsViewModel: ObservableObject {
    
    enum TabbedItems: Int, CaseIterable {
        case home = 0
        case account
        case order
        
        var title: String{
            switch self {
            case .home:
                return "Home"
            case .account:
                return "Account"
            case .order:
                return "Order"
            }
        }
        
        var iconName: String{
            switch self {
            case .home:
                return "house"
            case .account:
                return "person"
            case .order:
                return "bag"
            }
        }
    }
    
    @Published var selectedTab: TabbedItems = .home
    @Published var itemsTabbar: [TabbedItems] = []
    
    init() {
        itemsTabbar = [.home, .account, .order]
    }

    @ViewBuilder
    func view(for tab: TabbedItems) -> some View {
        switch tab {
        case .home:
            AnyView(AppetizerListView()
                .tag(tab.rawValue))
        case .account:
            AnyView(AccountView()
                .tag(tab.rawValue))
        case .order:
            AnyView(OrderView()
                .tag(tab.rawValue))
        }
    }
}
