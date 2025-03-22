//
//  ScrollToTopButton.swift
//  SwiftUIAnimation
//
//  Created by CallmeOni on 13/3/2568 BE.
//

import SwiftUI

struct ScrollToTopButton: View {
    
    @State var visibleItems: Set<Int> = Set()
    
    var body: some View {
        ScrollViewReader { proxy in
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(0...10, id: \.self) { index in
                        listItem(index)
                    }
                }
                
                let selectedID = 0
                if !visibleItems.contains(selectedID) {
                    Button {
                        withAnimation {
                            proxy.scrollTo(selectedID)
                        }
                    } label: {
                        Image(systemName: "chevron.up")
                            .padding(30)
                            .background(.gray)
                            .foregroundStyle(.white)
                    }
                    .padding()
                }
            }
        }
    }
    
    func listItem(_ num: Int) -> some View {
        Text("This is item \(num)")
            .padding(50)
            .id(num)
            .onAppear {
                visibleItems.insert(num)
            }
            .onDisappear {
                visibleItems.remove(num)
            }
    }
}

#Preview {
    ScrollToTopButton()
}
