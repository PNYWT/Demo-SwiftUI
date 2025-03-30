//
//  ActionModel.swift
//  SwiftUI-ScrollViewSwipeAction
//
//  Created by CallmeOni on 30/3/2568 BE.
//

import SwiftUI

struct ActionModel: Identifiable {
    private(set) var id: UUID = UUID()
    var tint: Color
    var icon: String
    var iconFont: Font = .title
    var iconTint: Color = .white
    var isEnabled: Bool = true
    var action: () -> ()
}

enum SwipeDirection {
    case leading
    case trailing
    
    var alignment: Alignment {
        switch self {
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

@resultBuilder
struct ActionBuilder {
    static func buildBlock(_ components: ActionModel...) -> [ActionModel] {
        return components
    }
}
