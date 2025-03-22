//
//  Date+Exention.swift
//  SwiftUI-Calendar
//
//  Created by CallmeOni on 22/3/2568 BE.
//

import Foundation

extension Date {
    func getAllDatesInMonth() -> [Date] {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: self),
              let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: self))
        else {
            return []
        }
        
        return range.compactMap { day -> Date? in
            // range.count = 32 days -> day - 1 = 31 or 30
            return calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
    }
}

