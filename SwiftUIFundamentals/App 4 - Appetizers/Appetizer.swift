//
//  Appetizer.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import Foundation

struct Appetizer: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let imageURL: String
    let calories: Int
    let protein: Int
    let carbs: Int
}

struct AppetizerResponse: Codable {
    let request: [Appetizer]
}

struct MockDataAppetizer {
    static let sampleAppetizer: Appetizer = .init(
        id: 0001,
        name: "Test name",
        description: "Test description",
        price: 100.00,
        imageURL: "",
        calories: 100,
        protein: 100,
        carbs: 100)
    
    static let appetizers = [sampleAppetizer, sampleAppetizer, sampleAppetizer]
}
