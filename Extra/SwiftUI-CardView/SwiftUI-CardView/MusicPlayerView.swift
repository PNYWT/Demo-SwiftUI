//
//  MusicPlayerView.swift
//  SwiftUI-CardView
//
//  Created by CallmeOni on 15/3/2568 BE.
//

import SwiftUI

struct MusicPlayerView: View {
    var body: some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.secondary)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Cool Song Title")
                        .font(.headline.bold())
                    
                    Text("Artist Name")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(.bottom, 8.0)
            
            ProgressView(value: 0.4, total: 1)
                .tint(.secondary)
                .padding(.bottom, 20)
            
            HStack(spacing: 30) {
                Image(systemName: "backward.fill")
                Image(systemName: "pause.fill")
                Image(systemName: "forward.fill")
            }
            .foregroundStyle(.secondary)
            .font(.title)
        }
    }
}

#Preview {
    MusicPlayerView()
}

struct MusicGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .bold()
                .foregroundStyle(.pink)
            configuration.content
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}
