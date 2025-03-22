//
//  ContentView.swift
//  SwiftUI-SwiftData
//
//  Created by CallmeOni on 14/3/2568 BE.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var context
    
    @State private var isShowingItemSheet = false
    @Query(filter: #Predicate<ExpenseModel> {
        $0.value > 100
    }, sort: \ExpenseModel.date)
    var expenses: [ExpenseModel]
    
//    @Query(sort: \ExpenseModel.date) var expenses: [ExpenseModel]
    @State private var expenseToEdit: ExpenseModel?

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses) { expense in
                    ExpenseCell(expense: expense)
                        .onTapGesture {
                            expenseToEdit = expense
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(expenses[index])
                    }
                }
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet) {
                AddExpenseSheet()
            }
            .sheet(item: $expenseToEdit, content: { expense in
                UpdateExpenseSheet(expense: expense)
            })
            .toolbar {
                if !expenses.isEmpty {
                    Button("Add Expense", systemImage: "plus") {
                        isShowingItemSheet = true
                    }
                }
            }
            .overlay {
                if expenses.isEmpty {
                    ContentUnavailableView {
                        Label("No Expenses", systemImage: "list.bullet.rectangle.portrait")
                    } description: {
                        Text("Start adding expenses to see your list.")
                    } actions: {
                        Button("Add Expenses") {
                            isShowingItemSheet = true
                        }
                    }
                    .offset(y: -60)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
