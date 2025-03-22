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
        guard let encoded = try? encoder.encode(user) else {
            return nil
        }
        UserDefaults.standard.set(encoded, forKey: "userModel")
        return encoded
    }
    
    func loadUser(data: Data) -> UserModel? {
        guard let userModel = try? JSONDecoder().decode(UserModel.self, from: data) else {
            return nil
        }
        return userModel
    }
}
