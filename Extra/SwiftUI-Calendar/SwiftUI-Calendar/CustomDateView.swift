//
//  CustomDateView.swift
//  SwiftUI-Calendar
//
//  Created by CallmeOni on 22/3/2568 BE.
//

import SwiftUI

struct CustomDateView: View {
    
    @Binding var currentDate: Date
    
    @State var currentMonth: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            headerView(date: currentDate)
                .padding(.horizontal)
            
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    daysView(day: day)
                }
            }
            
            let columns = Array(repeating: GridItem(.flexible()), count: days.count)
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate(month: currentMonth)) { modelDate in
                    CardView(modelDate: modelDate, selectDate: currentDate)
                        .onTapGesture {
                            currentDate = modelDate.date
                        }
                }
            }
            
            VStack(spacing: 16) {
                Text("Tasks")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let task = MockData.tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: currentDate)
                }) {
                    ForEach(task.task) { task in
                        VStack(alignment: .leading, spacing: 8) {
                           
                            Text(task.time
                                .addingTimeInterval(CGFloat.random(in: 0...5000)), style: .time)

                            
                            Text(task.title)
                                .font(.title2.bold())
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background {
                            Color.purple
                                .opacity(0.5)
                                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        }
                    }
                } else {
                    Text("No Task Found")
                }
            }
            .padding(.horizontal, 16)
        }
        .onChange(of: currentMonth) { _, newValue in
            currentDate = getCurrentMonth(month: newValue)
        }
        Spacer()
    }
    
    @ViewBuilder
    func headerView(date: Date) -> some View  {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text(extractDateToArrString(date: date)[0])
                    .font(.caption)
                    .fontWeight(.semibold)
                
                Text(extractDateToArrString(date: date)[1])
                    .font((.title.bold()))
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    currentMonth -= 1
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
            }
            
            Button {
                withAnimation {
                    currentMonth += 1
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title2)
            }
        }
    }
    
    @ViewBuilder
    func daysView(day: String) -> some View {
        Text(day)
            .font(.callout)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    func CardView(modelDate: DateModel, selectDate: Date)
    -> some View {
        let isToday = isSameDay(date1: modelDate.date, date2: selectDate)
        VStack {
            if modelDate.day != -1 {
                if let task = MockData.tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: modelDate.date)
                }) {
                    let isTaskToDay = isSameDay(date1: task.taskDate, date2: selectDate)
//                    ZStack {
//                        if isSameDay {
//                            Circle()
//                                .fill(.blue)
//                        }
//                        Text("\(modelDate.day)")
//                            .font(.title3.bold())
//                            .foregroundStyle(isSameDay ? .white : .primary)
//                    }
                    Text("\(modelDate.day)")
                        .font(.title3.bold())
                        .foregroundStyle(isTaskToDay ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    
                    Circle()
                        .fill(isTaskToDay ? .white : .pink)
                        .frame(width: 8, height: 8)
                } else {
                    Text("\(modelDate.day)")
                        .font(.title3.bold())
                        .foregroundStyle(isToday ? .white : .primary)
                }
            }
        }
        .padding(.vertical, 8)
        .frame(height: 60, alignment: .top)
        .background {
            Capsule()
                .fill(Color.pink)
                .padding(.horizontal, 8)
                .opacity(isToday ? 1 : 0)
        }
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // Date Function
    func extractDateToArrString(date: Date) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: date)
        
        return date.components(separatedBy: " ")
    }
    
    func extractDate(month: Int) -> [DateModel] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth(month: month)
        var days =  currentMonth.getAllDatesInMonth().compactMap { date -> DateModel in
            let day = calendar.component(.day, from: date)
            return DateModel(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateModel(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
    func getCurrentMonth(month: Int) -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: month, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
}

#Preview {
    CustomDateView(currentDate: .constant(Date()))
}

