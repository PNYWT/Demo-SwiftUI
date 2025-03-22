//
//  SwiftUI_SwiftDataApp.swift
//  SwiftUI-SwiftData
//
//  Created by CallmeOni on 14/3/2568 BE.
//

import SwiftUI
import SwiftData

@main
struct SwiftUI_SwiftDataApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ExpenseModel.self,
        ])
        let expenseModelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [expenseModelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
