//
//  ToDoListModel.swift
//  SwiftUI-ToDoList
//
//  Created by CallmeOni on 15/3/2568 BE.
//

import Foundation

struct ToDoListModel: Identifiable, Hashable, Equatable {
    let id = UUID()
    var title: String
    let date = Date()
    
    func checkTitleIsEmpty() -> Bool {
        return title.isEmpty
    }
    
    func deleteModel(list: [ToDoListModel]) -> Int? {
        return list.firstIndex(where: { $0.id == self.id }) ?? nil
    }
    
    func updateModel(list: [ToDoListModel]) -> Int? {
        return list.firstIndex(where: { $0.id == self.id }) ?? nil
    }
}

struct MockData {
    static let mockList: [ToDoListModel] = [
        .init(title: "Test1"),
        .init(title: "Test2"),
        .init(title: "Test3"),
        .init(title: "Test4"),
        .init(title: "Test5"),
        .init(title: "Test6"),
        .init(title: "Test7"),
        .init(title: "Test8"),
        .init(title: "Test9"),
        .init(title: "Test10")
    ]
}
