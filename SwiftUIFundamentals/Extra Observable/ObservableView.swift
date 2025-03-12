//
//  ObservableView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 12/3/2568 BE.
//

import SwiftUI
import Observation

// Old way
class UserObservableOld: ObservableObject {
    @Published var name: String
    @Published var count: Int
    
    init(name: String, count: Int) {
        self.name = name
        self.count = count
    }
}

// New way
/// Reduce unnecessary UI Update
@Observable class UserObservableNew {
    var name: String
    var count: Int
    
    init(name: String, count: Int) {
        self.name = name
        self.count = count
    }
}

struct ObservableView: View {
    
    var objectNew = UserObservableNew(name: "Me", count: 0)
    
    @ObservedObject var objectOld = UserObservableOld(name: "Me", count: 0)
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Observable")
                Spacer()
                Button {
                    objectNew.count += 1
                } label: {
                   Text("Tab: \(objectNew.count)")
                }
                .buttonStyle(.borderedProminent)
            }
            HStack {
                Text("ObservableObject")
                Spacer()
                Button {
                    objectOld.count += 1
                } label: {
                   Text("Tab: \(objectOld.count)")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .frame(width: 250)
    }
}

#Preview {
    ObservableView()
}
