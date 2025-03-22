//
//  AppAlertError.swift
//  SwiftUI-ToDoList
//
//  Created by CallmeOni on 15/3/2568 BE.
//

import SwiftUI

enum AppAlertError: LocalizedError {
    
    case invalidAddTodoList
    case Success(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidAddTodoList:
            "Invalid Username"
        case .Success(_):
            "Success"
        }
    }
    
    var failureReason: String {
        switch self {
        case .invalidAddTodoList:
            "Username can't be empty."
        case .Success(let message):
            message
        }
    }
}
