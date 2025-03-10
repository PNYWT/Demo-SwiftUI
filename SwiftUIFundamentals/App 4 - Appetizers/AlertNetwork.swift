//
//  AlertNetwork.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import SwiftUI

struct AlertItemNetwork: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContextNetwork {
    //MARK: - Network Alerts
    static let invalidData      = AlertItemNetwork(title: Text("Server Error"),
                                            message: Text("The data received from the server was invalid. Please contact support."),
                                            dismissButton: .default(Text("OK")))
    
    static let invalidResponse  = AlertItemNetwork(title: Text("Server Error"),
                                            message: Text("Invalid response from the server. Please try again later or contact support."),
                                            dismissButton: .default(Text("OK")))
    
    static let invalidURL       = AlertItemNetwork(title: Text("Sever Error"),
                                            message: Text("There was an issue connecting to the server. If this persists, please contact support."),
                                            dismissButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItemNetwork(title: Text("Server Error"),
                                            message: Text("Unable to complete your request at this time. Please check your internet connection."),
                                            dismissButton: .default(Text("OK")))
    
    
    //MARK: - Account Alerts
    static let invalidForm      = AlertItemNetwork(title: Text("Invalid Form"),
                                            message: Text("Please ensure all fields in the form have been filled out."),
                                            dismissButton: .default(Text("OK")))
    
    static let invalidEmail     = AlertItemNetwork(title: Text("Invalid Email"),
                                            message: Text("Please ensure your email is correct."),
                                            dismissButton: .default(Text("OK")))
    
    static let userSaveSuccess  = AlertItemNetwork(title: Text("Profile Saved"),
                                            message: Text("Your profile information was successfully saved."),
                                            dismissButton: .default(Text("OK")))
    
    static let invalidUserData  = AlertItemNetwork(title: Text("Profile Error"),
                                            message: Text("There was an error saving or retrieving your profile."),
                                            dismissButton: .default(Text("OK")))
}

