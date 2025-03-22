//
//  extension.swift
//  SwiftUI-ToDoList
//
//  Created by CallmeOni on 16/3/2568 BE.
//

import SwiftUI

extension View {
    func configureAlertsAction(for viewModel: ToDoListViewModel) -> some View {
        self.alert(viewModel.alertActionType?.title ?? "", isPresented: Binding(
            get: {
                viewModel.isAlertAction
            },
            set: {
                viewModel.isAlertAction = $0
            }
        ), presenting: viewModel.alertActionType) { action in
            if action == .inputTodoList {
                TextField("Value", text: Binding(
                    get: {
                        viewModel.addListTitle
                    },
                    set: {
                        viewModel.addListTitle = $0
                    }
                ))
                Button("Summit") { viewModel.checkTextisEmpty() }
                Button("Cancel", role: .cancel) {
                    viewModel.checkTextWhenCancel()
                }
            }
        } message: { error in
            Text(error.actionDescription)
        }
    }
    
    func configureAlertError(for viewModel: ToDoListViewModel) -> some View {
        self.alert("", isPresented: Binding(
            get: {
                viewModel.isAlertError
            },
            set: {
                viewModel.isAlertError = $0
            }
        ), presenting: viewModel.alertErrorType) { error in
            switch error {
            case .invalidAddTodoList:
                Button("OK") {
                    viewModel.showAddListAgain()
                }
            case .Success(_):
                Button("OK") {
                    viewModel.addListSuccess()
                }
            }
        } message: { error in
            Text(error.failureReason)
        }
    }
}

