//
//  ContentView.swift
//  SwiftUI-BarChart
//
//  Created by CallmeOni on 16/3/2568 BE.
//

import SwiftUI
import Charts

struct ViewMonth: Identifiable {
    let id = UUID()
    let date: Date
    let viewCount: Int
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}

struct ContentView: View {
    
    let viewMonths: [ViewMonth] = [
        .init(date: Date.from(year: 2023, month: 1, day: 1), viewCount: 55000),
        .init(date: Date.from(year: 2023, month: 2, day: 1), viewCount: 89000),
        .init(date: Date.from(year: 2023, month: 3, day: 1), viewCount: 62000),
        .init(date: Date.from(year: 2023, month: 4, day: 1), viewCount: 78000),
        .init(date: Date.from(year: 2023, month: 5, day: 1), viewCount: 95000),
        .init(date: Date.from(year: 2023, month: 6, day: 1), viewCount: 102000),
        .init(date: Date.from(year: 2023, month: 7, day: 1), viewCount: 87000),
        .init(date: Date.from(year: 2023, month: 8, day: 1), viewCount: 94000),
        .init(date: Date.from(year: 2023, month: 9, day: 1), viewCount: 112000),
        .init(date: Date.from(year: 2023, month: 10, day: 1), viewCount: 98000),
        .init(date: Date.from(year: 2023, month: 11, day: 1), viewCount: 105000),
        .init(date: Date.from(year: 2023, month: 12, day: 1), viewCount: 118000)
    ]
    
    @State private var rawSelectedDate: Date?
    var selectedViewMonth: ViewMonth? {
        guard let rawSelectedDate else { return nil }
        return viewMonths.first {
            Calendar.current.isDate(rawSelectedDate, equalTo: $0.date, toGranularity: .month)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Sale Values")
            
            Text("Toal: \(viewMonths.reduce(0, { $0 + $1.viewCount }))")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.bottom, 12)
            
            Chart {
                if let selectedViewMonth {
                    RuleMark(x: .value("Selected Month", selectedViewMonth.date, unit: .month))
                        .foregroundStyle(.secondary.opacity(0.3))
                        .annotation(position: .top, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                            VStack {
                                Text(selectedViewMonth.date, format: .dateTime.month(.wide))
                                    .bold()
                                
                                Text("\(selectedViewMonth.viewCount)")
                                    .font(.title3.bold())
                            }
                            .foregroundStyle(.white)
                            .padding(12)
                            .frame(width: 120)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.pink.gradient))
                        }
                }
                ForEach(viewMonths) { viewMonth in
                    // BarMark
                    // LineMark
                    BarMark(
                        x: .value("Month", viewMonth.date, unit: .month),
                        y: .value("Views", viewMonth.viewCount)
                    )
                    .foregroundStyle(.pink.gradient)
                    .opacity(rawSelectedDate == nil || viewMonth.date == selectedViewMonth?.date ? 1.0 : 0.3)
                }
                RuleMark(y: .value("Goal", 80000))
                    .foregroundStyle(.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
//                    .annotation(alignment: .leading) {
//                        Text("Goal")
//                            .font(.caption)
//                            .foregroundStyle(.secondary)
//                    }
            }
            .frame(height: 180)
            .chartXSelection(value: $rawSelectedDate.animation(.easeInOut))
            .onChange(of: selectedViewMonth?.viewCount, { oldValue, newValue in
                print("newValue -> \(newValue)")
            })
            // Scale
//            .chartYScale(domain: 0...200000)
            // Style
            .chartXAxis {
                AxisMarks(values: viewMonths.map( { $0.date } )) { date in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.month(.abbreviated), centered: true)
                }
            }
            .chartYAxis {
                AxisMarks { mark in
                    AxisValueLabel()
                    AxisGridLine()
                }
            }
//            .chartXAxis(.hidden)
//            .chartYAxis(.hidden)
//            .chartPlotStyle { chart in
//                chart
//                    .background(.black.gradient.opacity(0.3))
//                    .border(.green, width: 3)
//            }
            HStack {
                Image(systemName: "line.diagonal")
                    .rotationEffect(Angle(degrees: 45))
                    .foregroundStyle(.mint)
                
                Text("Monthly Goal")
                    .foregroundStyle(.secondary)
            }
            .font(.caption2)
            .padding(.leading, 4)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
