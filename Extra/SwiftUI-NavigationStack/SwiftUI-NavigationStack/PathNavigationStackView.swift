//
//  PathNavigationStackView.swift
//  SwiftUI-NavigationStack
//
//  Created by CallmeOni on 14/3/2568 BE.
//

import SwiftUI

struct PathNavigationStackView: View {
    
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
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
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
                    VStack {
                        Label {
                            Text(platform.name)
                                .font(.largeTitle).bold()
                        } icon: {
                            Image(systemName: platform.imageName)
                                .font(.largeTitle).bold()
                        }
                        List {
                            ForEach(games, id: \.name) { game in
                                NavigationLink(value: game, label: {
                                    Text(game.name)
                                })
                            }
                        }
                    }
                }
            }
            
            .navigationDestination(for: Game.self) { game in
                VStack(spacing: 20) {
                    Text("\(game.name) - Score: \(game.rating)")
                        .font(.title).bold()
                    
                    Button("Recommended game") {
                        path.append(games.randomElement()!)
                    }
                    
                    Button("Go to another platform") {
                        path.append(platforms.randomElement()!)
                    }
                    
                    Button("Go Home") {
                        path.removeLast(path.count)
                    }
                }
            }
        }
    }
}

#Preview {
    PathNavigationStackView()
}
