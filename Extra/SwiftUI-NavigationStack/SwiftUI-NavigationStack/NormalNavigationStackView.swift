//
//  NormalNavigationStackView.swift
//  SwiftUI-NavigationStack
//
//  Created by CallmeOni on 14/3/2568 BE.
//

import SwiftUI

struct Platform: Hashable {
    let name: String
    let imageName: String
    let color: Color
}

struct Game: Hashable {
    let name: String
    let rating: String
}

struct NormalNavigationStackView: View {
    
    var platforms: [Platform] = [
        .init(name: "Xbox", imageName: "xbox.logo", color: .green),
        .init(name: "Playstation", imageName: "playstation.logo", color: .indigo),
        .init(name: "PC", imageName: "pc", color: .pink),
        .init(name: "Mobile", imageName: "iphone", color: .mint)
    ]
    
    var games: [Game] = [
        .init(name: "Monster Hunter Wilds", rating: "100"),
        .init(name: "God of War", rating: "98"),
        .init(name: "Split Fiction", rating: "90")
    ]
    
    var body: some View {
        NavigationStack() {
            List {
                Section("Platform") {
                    ForEach(platforms, id: \.name) { platform in
                        NavigationLink(value: platform, label: {
                            Label {
                                Text(platform.name)
                            } icon: {
                                Image(systemName: platform.imageName)
                            }
                            .foregroundStyle(platform.color)
                        })
                        
                    }
                }
                
                Section("Game") {
                    ForEach(games, id: \.name) { game in
                        NavigationLink(value: game, label: {
                            Text(game.name)
                        })
                        
                    }
                }
            }
            .navigationTitle("Gaming")
            .navigationDestination(for: Platform.self) { platform in
                // View ที่จะเปิดไป
                ZStack {
                    platform.color.ignoresSafeArea()
                    Label {
                        Text(platform.name)
                            .font(.largeTitle).bold()
                    } icon: {
                        Image(systemName: platform.imageName)
                            .font(.largeTitle).bold()
                    }
                }
            }
            
            .navigationDestination(for: Game.self) { game in
                Text("\(game.name) - Score: \(game.rating)")
                    .font(.title).bold()
            }
        }
    }
}

#Preview {
    NormalNavigationStackView()
}
