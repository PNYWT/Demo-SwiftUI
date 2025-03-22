//
//  ExpenseCell.swift
//  SwiftUI-SwiftData
//
//  Created by CallmeOni on 15/3/2568 BE.
//

import SwiftUI

struct ExpenseCell: View {
    
    let expense: ExpenseModel
    
    var body: some View {
        HStack {
            Text(expense.date, format: .dateTime.month(.abbreviated).day())
                .frame(width: 70, alignment: .leading)
            Text(expense.name)
            Spacer()
            Text(expense.value, format: .currency(code: "USD"))
        }
    }
}

#Preview {
    ExpenseCell(expense: .init(name: "Test Expense", date: .init(), value: 99.0))
}
