//
//  ContentView.swift
//  SwiftUI-CardView
//
//  Created by CallmeOni on 15/3/2568 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.mint.gradient.opacity(0.8))
                .ignoresSafeArea()
            VStack(spacing: 20) {
                GroupBox("My Content") {
                    Text("This my groupbox. Isn't it cool. it's like a card view. Awesone!")
                }
                .padding(.horizontal, 16)
                
                GroupBox {
                    Text("This my groupbox. Isn't it cool. it's like a card view. Awesone!")
                } label: {
                    Label("Now Playing", systemImage: "music.note")
                }
                
                GroupBox {
                    GroupBox {
                        MusicPlayerView()
                    }
                    .groupBoxStyle(MusicGroupBoxStyle())
                } label: {
                    Label("Now Playing", systemImage: "music.note")
                }
                .groupBoxStyle(MusicGroupBoxStyle())
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
