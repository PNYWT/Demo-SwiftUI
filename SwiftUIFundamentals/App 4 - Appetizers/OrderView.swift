//
//  OrderView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import SwiftUI

struct OrderView: View {
    var body: some View {
        NavigationView {
            Text("Orders")
                .navigationTitle(Text("🛒 Orders"))
        }
    }
}

#Preview {
    OrderView()
}
