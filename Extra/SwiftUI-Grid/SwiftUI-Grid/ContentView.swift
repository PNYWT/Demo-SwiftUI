//
//  ContentView.swift
//  SwiftUI-Grid
//
//  Created by CallmeOni on 13/3/2568 BE.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var isOn = false
    
    var body: some View {
        Grid(horizontalSpacing: 15, verticalSpacing: 15) {
            GridRow {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.pink.gradient)
                    .frame(width: 100, height: 100)
                    .gridColumnAlignment(.center)
                VStack {
                    Circle()
                        .foregroundStyle(.secondary)
                        .frame(width: 60, height: 60)
                    
                    Text("Hi")
                }
                
                VStack {
                    Button("Tap") {
                        
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Toggle("Volume", isOn: $isOn)
                        .labelsHidden()
                }
            }
            Divider()
            
            GridRow {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.teal.gradient)
                    .frame(height: 100)
                    .gridCellColumns(3)
            }
        }
    }
    
    private let rows = Array(repeating: GridItem(.fixed(100)), count: 3)
    
    var scrollGridHView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(MockData.colors, id: \.self) { color in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(color.gradient)
                        .frame(width: 100)
                }
            }
            .padding()
        }
    }
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 4)
//    [GridItem(.adaptive(minimum: 60))]
//    Array(repeating: GridItem(.fixed(100)), count: 3)
    var scrollGridVView: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 20, pinnedViews: .sectionHeaders) {
                
                Section {
                    ForEach(MockData.colors, id: \.self) { color in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(color.gradient)
                            .frame(height: 100)
                    }
                } header: {
                    Text("Favorites")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Section {
                    ForEach(MockData.colors, id: \.self) { color in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(color.gradient)
                            .frame(height: 100)
                    }
                } header: {
                    Text("Other Color")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
