//
//  TaskModel.swift
//  SwiftUI-Calendar
//
//  Created by CallmeOni on 22/3/2568 BE.
//

import Foundation

struct TaskMetaData: Identifiable {
    var id = UUID()
    var task: [TaskModel]
    var taskDate: Date
}

struct TaskModel: Identifiable {
    var id = UUID()
    var title: String
    var time: Date = Date()
}

func getSmapleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

struct MockData {
    static var tasks = [
        TaskMetaData.init(task: [
            TaskModel(title: "SameDate"),
        ], taskDate: getSmapleDate(offset: 0)),
        TaskMetaData.init(task: [
            TaskModel(title: "111111111"),
            TaskModel(title: "222222222"),
            TaskModel(title: "333333333")
        ], taskDate: getSmapleDate(offset: 1)),
        TaskMetaData.init(task: [
            TaskModel(title: "AAAAA"),
            TaskModel(title: "BBBBB"),
        ], taskDate: getSmapleDate(offset: 2)),
        TaskMetaData.init(task: [
            TaskModel(title: "AB"),
            TaskModel(title: "BC"),
        ], taskDate: getSmapleDate(offset: 8)),
        TaskMetaData.init(task: [
            TaskModel(title: "-4A"),
            TaskModel(title: "-4B"),
        ], taskDate: getSmapleDate(offset: -4))
    ]
}
