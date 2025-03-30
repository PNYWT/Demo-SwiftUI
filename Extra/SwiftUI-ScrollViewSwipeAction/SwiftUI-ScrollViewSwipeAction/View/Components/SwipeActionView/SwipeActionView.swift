//
//  SwipeActionView.swift
//  SwiftUI-ScrollViewSwipeAction
//
//  Created by CallmeOni on 30/3/2568 BE.
//

import SwiftUI

struct SwipeActionView<Content: View>: View {
    
    private var conrnerRadius: CGFloat = 0
    private var direction: SwipeDirection = .trailing
    private var content: Content
    private var actions: [ActionModel]
    
    @Environment(\.colorScheme) private var scheme
    
    // Unique ID
    private let viewID = "CONTENTVIEW"
    @State private var isEnabled: Bool = true
    private var filteredActions: [ActionModel] {
        return actions.filter( {
            $0.isEnabled
        })
    }
    @State private var scrollOffset: CGFloat = .zero
    
    init(conrnerRadius: CGFloat = 0,
         direction: SwipeDirection = .trailing,
         @ViewBuilder content: () -> Content,
         @ActionBuilder actions: () -> [ActionModel]
    ) {
        self.conrnerRadius = conrnerRadius
        self.direction = direction
        self.content = content()
        self.actions = actions()
    }
    
    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(.horizontal) {
                LazyHStack {
                    content
                        .rotationEffect(.init(degrees: direction == .trailing ? 0 : -180))
                        .containerRelativeFrame(.horizontal)
                        .background {
                            scheme == .dark ? Color.black : .white
                        }
                        .background {
                            backgroundFill(actionModel: filteredActions.first)
                        }
                        .id(viewID)
                        .transition(.identity)
                        .overlay {
                            trackingOverlay
                        }
                        .onTapGesture {
                            withAnimation(.snappy) {
                                scrollViewProxy.scrollTo(viewID, anchor: direction == .trailing ? .topLeading : .topTrailing)
                            }
                        }
                    
                    actionButtons {
                        withAnimation(.snappy) {
                            scrollViewProxy.scrollTo(viewID, anchor: direction == .trailing ? .topLeading : .topTrailing)
                        }
                    }
                    .opacity(scrollOffset == .zero ? 0 : 1)
                }
                .scrollTargetLayout()
                .visualEffect { content, geometryProxy in
                    content
                        .offset(x: scrollOffset(proxy: geometryProxy))
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .background {
                backgroundFill(actionModel: filteredActions.last)
            }
            .clipShape(.rect(cornerRadius: conrnerRadius))
            .rotationEffect(.init(degrees: direction == .trailing ? 0 : 180))
        }
        .allowsHitTesting(isEnabled)
        .transition(CustomTransition())
    }
    
    @ViewBuilder
    private var trackingOverlay: some View {
        GeometryReader { geometryProxy in
            let minX = geometryProxy.frame(in: .scrollView(axis: .horizontal)).minX
            
            Color.clear
                .preference(key: OffsetKey.self, value: minX)
                .onPreferenceChange(OffsetKey.self) { value in
                    scrollOffset = value
                }
        }
    }
    
    @ViewBuilder
    private func backgroundFill(actionModel: ActionModel?) -> some View {
        if let action = actionModel {
            Rectangle()
                .fill(action.tint)
                .opacity(scrollOffset == .zero ? 0 : 1)
        }
    }
    
    private func actionButtons(resetPosition: @escaping () -> ()) -> some View {
        let widthButtonAction: CGFloat = 100.0
        return Rectangle()
            .fill(.clear)
            .frame(width: CGFloat(filteredActions.count) * widthButtonAction)
            .overlay(alignment: direction.alignment) {
                HStack {
                    ForEach(filteredActions) { action in
                        Button {
                            Task {
                                isEnabled = false
                                resetPosition()
                                try? await Task.sleep(for: .seconds(0.25))
                                action.action()
                                try? await Task.sleep(for: .seconds(0.10))
                                isEnabled = true
                            }
                        } label: {
                            Image(systemName: action.icon)
                                .font(action.iconFont)
                                .foregroundStyle(action.iconTint)
                                .frame(width: widthButtonAction)
                                .frame(maxHeight: .infinity)
                                .contentShape(.rect)
                        }
                        .buttonStyle(.plain)
                        .background {
                            action.tint
                        }
                        .rotationEffect(.init(degrees: direction == .trailing ? 0 : -180))
                    }
                }
            }
    }
    
    nonisolated private func scrollOffset(proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        
        return minX > 0 ? -minX : 0
    }
}

#Preview {
    Home()
    /*
     var colors = [Color.black, .yellow, .purple, .brown]
     LazyVStack(spacing: 8) {
     ForEach(colors, id: \.self) { color in
     SwipeActionView(conrnerRadius: 16, direction: .trailing) {
     CardView(color: color)
     } actions: {
     ActionModel(tint: .red, icon: "trash") {
     print("Deleted")
     withAnimation(.easeInOut) {
     colors.removeAll { item in
     return item == color
     }
     }
     }
     ActionModel(tint: .blue, icon: "pencil") {
     print("Edited")
     }
     }
     }
     }
     .padding(8)
     */
}

