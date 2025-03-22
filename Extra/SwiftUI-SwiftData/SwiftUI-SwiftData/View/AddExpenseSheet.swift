//
//  AddExpenseSheet.swift
//  SwiftUI-SwiftData
//
//  Created by CallmeOni on 15/3/2568 BE.
//

import SwiftUI

struct AddExpenseSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    
    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var value: Double = 0
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense Name", text: $name)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                TextField("Value", value: $value, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        // Save
                        let expense = ExpenseModel(name: name, date: date, value: value)
                        context.insert(expense) // auto save
//                        try? context.save()
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddExpenseSheet()
}
