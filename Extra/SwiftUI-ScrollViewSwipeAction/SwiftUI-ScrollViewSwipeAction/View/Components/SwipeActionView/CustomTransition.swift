//
//  CustomTransition.swift
//  SwiftUI-ScrollViewSwipeAction
//
//  Created by CallmeOni on 30/3/2568 BE.
//

import SwiftUI

struct CustomTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .mask {
                GeometryReader {
                    let size = $0.size
                    
                    Rectangle()
                        .offset(y: phase == .identity ? 0 : -size.height)
                }
                .containerRelativeFrame(.horizontal)
            }
    }
}
