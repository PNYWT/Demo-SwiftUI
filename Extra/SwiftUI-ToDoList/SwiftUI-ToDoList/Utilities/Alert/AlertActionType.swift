//
//  AlertActionType.swift
//  SwiftUI-ToDoList
//
//  Created by CallmeOni on 16/3/2568 BE.
//

import SwiftUI

enum AlertActionType: LocalizedError {
    
    case inputTodoList
    
    var actionDescription: String {
        switch self {
        case .inputTodoList:
            "Please input your todo list."
        }
    }
    
    var title: String {
        switch self {
        case .inputTodoList:
            "Input your List"
        }
    }
}
