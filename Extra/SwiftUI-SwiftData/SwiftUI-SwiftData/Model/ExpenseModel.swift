//
//  ExpenseModel.swift
//  SwiftUI-SwiftData
//
//  Created by CallmeOni on 14/3/2568 BE.
//

import Foundation
import SwiftData

@Model
class ExpenseModel {
    @Attribute(.unique) private var timestamp: Date
    var name: String
    var date: Date
    var value: Double
    
    init(name: String, date: Date, value: Double) {
        self.timestamp = Date()
        self.name = name
        self.date = date
        self.value = value
    }
}
