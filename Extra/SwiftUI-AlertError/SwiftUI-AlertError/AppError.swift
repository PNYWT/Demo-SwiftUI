//
//  AppError.swift
//  SwiftUI-AlertError
//
//  Created by CallmeOni on 15/3/2568 BE.
//

import Foundation

enum AppError: LocalizedError {
    case invalidUserName
    case invalidPassword
    case noNetwork
    
    var errorDescription: String? {
        switch self {
        case .invalidUserName:
            "Invalid Username"
        case .invalidPassword:
            "Invalid Password"
        case .noNetwork:
            "No Network Connection"
        }
    }
    
    var failureReason: String {
        switch self {
        case .invalidUserName:
            "The username entered does not exist in our database."
        case .invalidPassword:
            "The password entered for the username is incorrect."
        case .noNetwork:
            "Unable to detect a network connection. Please connect to wi-fi or cellular and try again."
        }
    }
}
