//
//  ChipsView.swift
//  SwiftUI-Chips
//
//  Created by CallmeOni on 23/3/2568 BE.
//

import SwiftUI

struct ChipsView<Content: View, Tag: Equatable>: View where Tag: Hashable {
    var spacing: CGFloat = 8
    var tags: [Tag]
    @ViewBuilder var content: (Tag, Bool) -> Content
    var didChangeSelection: ([Tag]) -> ()
    var animaion: Animation = .easeInOut(duration: 0.2)
    
    @State private var selectedTags: [Tag] = []
    var body: some View {
        CustomChipLayout(spacing: spacing) {
            ForEach(tags, id: \.self) { tag in
                content(tag, selectedTags.contains(tag))
                    .contentShape(.rect)
                    .onTapGesture {
                        withAnimation(animaion) {
                            if selectedTags.contains(tag) {
                                selectedTags.removeAll(where: {
                                    $0 == tag
                                })
                            } else {
                                selectedTags.append(tag)
                            }
                        }
                        
                        didChangeSelection(selectedTags)
                    }
            }
        }
    }
}

fileprivate struct CustomChipLayout: Layout {
    
    var spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? .zero
        return .init(width: width, height: maxHeight(proposal: proposal, subviews: subviews))
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        
        subviews.forEach { subview in
            let fitSize = subview.sizeThatFits(proposal)
            
            if origin.x + fitSize.width > bounds.maxX {
                origin.x = bounds.minX
                origin.y += fitSize.height + spacing
                
                subview.place(at: origin, proposal: proposal)
                origin.x += fitSize.width + spacing
            } else {
                subview.place(at: origin, proposal: proposal)
                origin.x += fitSize.width + spacing
                
            }
        }
    }
    
    private func maxHeight(proposal: ProposedViewSize, subviews: Subviews) -> CGFloat {
        var origin: CGPoint = .zero
        
        subviews.forEach { subview in
            let fitSize = subview.sizeThatFits(proposal)
            
            if origin.x + fitSize.width > (proposal.width ?? 0) {
                origin.x = 0
                origin.y += fitSize.height + spacing
                origin.x += fitSize.width + spacing
            } else {
                origin.x += fitSize.width + spacing
            }
            
            if subview == subviews.last {
                origin.y += fitSize.height
            }
        }
        
        return origin.y
    }
}

#Preview {
    ContentView()
}
