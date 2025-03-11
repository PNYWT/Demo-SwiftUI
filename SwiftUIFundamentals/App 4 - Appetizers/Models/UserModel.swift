//
//  UserModel.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 11/3/2568 BE.
//

import Foundation

struct UserModel: Codable {
    
    var firstName: String   = ""
    var lastName: String    = ""
    var email: String       = ""
    var birthday: Date      = Date()
    var extraNapkins        = false
    var frequentRefills     = false
    
    func saveUser(_ user: UserModel) -> Data? {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: "userModel")
            return encoded
        }
        return nil
    }
    
    func loadUser(data: Data) -> UserModel? {
        if let userModel = try? JSONDecoder().decode(UserModel.self, from: data) {
            return userModel
        }
        return nil
    }
}
