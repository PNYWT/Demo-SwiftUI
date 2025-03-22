//
//  ToDoListViewModel.swift
//  SwiftUI-ToDoList
//
//  Created by CallmeOni on 15/3/2568 BE.
//

import SwiftUI

class ToDoListViewModel: ObservableObject {
    
    @Published var list: [ToDoListModel] = MockData.mockList
    
    @Published var alertActionType: AlertActionType?
    @Published var isAlertAction = false
    @Published var alertErrorType: AppAlertError?
    @Published var isAlertError = false
    
    private var modelAdd: ToDoListModel?
    @Published var addListTitle: String = ""
    
    @Published var selectedModel: ToDoListModel? = nil
}

// MARK: Add List
extension ToDoListViewModel {
    
    func addList() {
        alertActionType = .inputTodoList
        isAlertAction = true
    }
    
    func checkTextisEmpty() {
        let model = ToDoListModel(title: addListTitle)
        if model.checkTitleIsEmpty() {
            alertErrorType = .invalidAddTodoList
        } else {
            modelAdd = model
            alertErrorType = .Success("Add List Success")
            addListTitle = ""
        }
        isAlertError = true
    }
    
    func addListSuccess() {
        guard let haveModel = modelAdd else { return }
        list.append(haveModel)
    }
    
    func checkTextWhenCancel() {
        addListTitle = ""
        isAlertAction = false
    }
    
    func showAddListAgain() {
        isAlertError = false
        checkTextWhenCancel()
        addList()
    }
}

// MARK: Delete Row
extension ToDoListViewModel {
    func deleteRowAt(model: ToDoListModel) {
        if let index = model.deleteModel(list: list) {
            list.remove(at: index)
//            list.removeAll { $0.id == model.id }
        }
    }
}

// MARK: Save Edit data
extension ToDoListViewModel {
    func saveEditData(updatedModel: ToDoListModel) {
        if let index = updatedModel.updateModel(list: list) {
            list[index] = updatedModel
            selectedModel = nil

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self = self else { return }
                self.alertErrorType = .Success("Edit List Success")
                self.isAlertError = true
            }
        }
    }
}

// MARK: Move Re-Order
extension ToDoListViewModel {
    func moveItem(from source: IndexSet, to destination: Int) {
        list.move(fromOffsets: source, toOffset: destination)
    }
}
