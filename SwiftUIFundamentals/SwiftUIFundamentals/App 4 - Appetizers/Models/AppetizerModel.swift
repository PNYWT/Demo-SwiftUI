//
//  AppetizerModel.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import Foundation

struct AppetizerModel: Codable, Identifiable {
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
    let request: [AppetizerModel]
}

struct MockDataAppetizer {
    static let sampleAppetizer: AppetizerModel = .init(
        id: 0001,
        name: "Test name",
        description: "Test description Test description Test description Test description",
        price: 100.00,
        imageURL: "",
        calories: 100,
        protein: 100,
        carbs: 100)
    
    static let appetizers = [sampleAppetizer, sampleAppetizer, sampleAppetizer]
    
    static let orderItems = [orderItemOne, orderItemTwo, orderItemThree]
    
    static let orderItemOne: AppetizerModel = .init(
        id: 0001,
        name: "Test name 1",
        description: "Test description Test description Test description Test description",
        price: 100.00,
        imageURL: "",
        calories: 100,
        protein: 100,
        carbs: 100)
    
    static let orderItemTwo: AppetizerModel = .init(
        id: 0002,
        name: "Test name 2",
        description: "Test description Test description Test description Test description",
        price: 100.00,
        imageURL: "",
        calories: 100,
        protein: 100,
        carbs: 100)
    
    static let orderItemThree: AppetizerModel = .init(
        id: 0003,
        name: "Test name 3",
        description: "Test description Test description Test description Test description",
        price: 100.00,
        imageURL: "",
        calories: 100,
        protein: 100,
        carbs: 100)
}
