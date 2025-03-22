//
//  OrderView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var orderViewModel: OrderViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(orderViewModel.items) { appetizer in
                            AppetizerListCell(appetizer: appetizer)
                                .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: orderViewModel.deleteItems)
                    }
                    .listStyle(.plain)
                    
                    Button {
                        print("Order placed")
                    } label: {
                        PrimaryCartButton(price: orderViewModel.totalPrice, title: "Place - Order")
                    }
                    .padding(.bottom, 24)
                }
                if orderViewModel.items.isEmpty {
                    EmptyOrderView(imageName: .emptyOrder, message: "You have no item in your order.\nPlease add some.")
                }
            }
            .navigationTitle(Text("🛒 Orders"))
        }
    }
}

#Preview {
    OrderView()
}
