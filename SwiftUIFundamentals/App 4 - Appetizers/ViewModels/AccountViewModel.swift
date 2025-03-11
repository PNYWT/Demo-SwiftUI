//
//  AccountViewModel.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 11/3/2568 BE.
//

import SwiftUI

final class AccountViewModel: ObservableObject {
    
    @AppStorage("userModel") private var userData: Data?
    
    @Published var userModel = UserModel()
    @Published var alertItem: AlertItemAppertizer?
    
    func saveChange() {
        guard isValidForm else {
            return
        }
        print("Change have been saved successfully")
        userData = userModel.saveUser(userModel)
        if userData != nil {
            alertItem = AlertContextAppertizer.userSaveSuccess
        } else {
            alertItem = AlertContextAppertizer.invalidUserData
        }
    }
    
    func retrieveUser() {
        guard let userData = userData else { return }
        if let haveUserModel = userModel.loadUser(data: userData) {
            userModel = haveUserModel
        } else {
            alertItem = AlertContextAppertizer.invalidUserData
        }
    }
    
    var isValidForm: Bool {
        guard !userModel.firstName.isEmpty, !userModel.lastName.isEmpty, !userModel.email.isEmpty else {
            alertItem = AlertContextAppertizer.invalidForm
            return false
        }
        guard userModel.email.isValidEmail else {
            alertItem = AlertContextAppertizer.invalidEmail
            return false
        }
        return true
    }
}
