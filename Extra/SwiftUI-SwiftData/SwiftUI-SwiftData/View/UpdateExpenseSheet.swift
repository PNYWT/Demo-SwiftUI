//
//  UpdateExpenseSheet.swift
//  SwiftUI-SwiftData
//
//  Created by CallmeOni on 15/3/2568 BE.
//

import SwiftUI

struct UpdateExpenseSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @Bindable var expense: ExpenseModel
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense Name", text: $expense.name)
                DatePicker("Date", selection: $expense.date, displayedComponents: .date)
                TextField("Value", value: $expense.value, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Update Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    UpdateExpenseSheet(expense: .init(name: "Test Expense", date: .init(), value: 99.0))
}
