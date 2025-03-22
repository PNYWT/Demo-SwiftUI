//
//  OrderViewModel.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 12/3/2568 BE.
//

import SwiftUI

final class OrderViewModel: ObservableObject {
    
    @Published var items: [AppetizerModel] = []
    
    var totalPrice: Double {
        items.reduce(0) { partialResult, item in
            partialResult + item.price
        }
        // items.reduce(0) { $0 + $1.price }
    }
    
    func addItem(_ appetizer: AppetizerModel) {
        items.append(appetizer)
    }
    
    func deleteItems(at atOffsets: IndexSet) {
        items.remove(atOffsets: atOffsets)
    }
}
