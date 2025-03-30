//
//  ContentView.swift
//  SwiftUI-Chips
//
//  Created by CallmeOni on 23/3/2568 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ChipsView(tags: MockData.tags) { tags, isSelected in
                    chipView(tag: tags, isSelected: isSelected)
                } didChangeSelection: { selection in
                    print("selection -> \(selection)")
                }
                .padding(8)
                .background(.gray.opacity(0.1), in: .rect(cornerRadius: 16))
                Spacer()
            }
            .padding(16)
            .navigationTitle("Chips")
        }
    }
    
    @ViewBuilder
    func chipView(tag: String, isSelected: Bool) -> some View {
        HStack(spacing: 10) {
            Text(tag)
                .font(.callout)
                .foregroundStyle(isSelected ? .white : .red)
            
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.white)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background {
            ZStack {
                Capsule()
                    .fill(.background)
                    .opacity(!isSelected ? 1 : 0)
                
                Capsule()
                    .fill(.green.gradient)
                    .opacity(isSelected ? 1 : 0)
            }
        }
    }
}

#Preview {
    ContentView()
}
