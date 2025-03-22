//
//  EditDetailPage.swift
//  SwiftUI-ToDoList
//
//  Created by CallmeOni on 16/3/2568 BE.
//

import SwiftUI

struct EditDetailPageView: View {
    
    @State var editTodoModel: ToDoListModel
    @State var titleEdit: String = ""
    var onSave: ((ToDoListModel) -> Void)?
    
    var body: some View {
        ZStack {
            Color.mint
            VStack {
                TextField("Edit Title", text: $titleEdit)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onAppear {
                        titleEdit = editTodoModel.title
                    }
                    .onSubmit {
                        if titleEdit.isEmpty {
                            titleEdit = editTodoModel.title
                        }
                    }
                Button("Save") {
                    if !titleEdit.isEmpty {
                        editTodoModel.title = self.titleEdit
                        onSave?(editTodoModel)
                    }
                }
                .buttonStyle(.borderedProminent)
                .cornerRadius(8)
            }
        }
        .frame(height: 150)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

#Preview {
    EditDetailPageView(editTodoModel: MockData.mockList.first!)
}
