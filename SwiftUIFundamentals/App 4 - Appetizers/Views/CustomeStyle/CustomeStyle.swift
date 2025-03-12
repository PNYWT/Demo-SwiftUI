//
//  CustomeStyle.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 12/3/2568 BE.
//

import SwiftUI

struct StandardButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .tint(.darkGreen)
            .controlSize(.large)
    }
}

extension View {
    func standardButtonStyle() -> some View  {
        return self.modifier(StandardButtonStyle())
    }
}
