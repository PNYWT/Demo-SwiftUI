//
//  ContentView.swift
//  SwiftUI-ToDoList
//
//  Created by CallmeOni on 15/3/2568 BE.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var todoListViewModel = ToDoListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(todoListViewModel.list, id: \.id) { model in
                    listCell(model: model)
                }
                .onMove(perform: todoListViewModel.moveItem)
            }
            .safeAreaInset(edge: .bottom) {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.pink.gradient.opacity(0.8))
                    .frame(maxWidth: .infinity, maxHeight: 70)
                    .padding(.horizontal)
            }
            .navigationTitle("📝 To do list")
            .navigationDestination(item: $todoListViewModel.selectedModel) { model in
                EditDetailPageView(editTodoModel: model) { modelEdit in
                    todoListViewModel.saveEditData(updatedModel: modelEdit)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        todoListViewModel.addList()
                    } label: {
                        Text("Add List")
                    }
                }
            }
        }
        .configureAlertsAction(for: todoListViewModel)
        .configureAlertError(for: todoListViewModel)
    }
    
    private func listCell(model: ToDoListModel) -> some View {
        Text(model.title)
            .swipeActions {
                Button(role: .destructive) {
                    todoListViewModel.deleteRowAt(model: model)
                } label: {
                    Image(systemName: "xmark.bin")
                        .resizable()
                }
                .tint(.red)
                
                Button {
                    todoListViewModel.selectedModel = model
                } label: {
                    Text("Edit")
                }
                .tint(.gray)
            }
            .frame(height: 80)
    }
}

#Preview {
    ContentView()
}
