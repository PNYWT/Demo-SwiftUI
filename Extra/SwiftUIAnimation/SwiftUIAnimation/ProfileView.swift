//
//  ProfileView.swift
//  SwiftUIAnimation
//
//  Created by CallmeOni on 15/3/2568 BE.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var isProfileExpanded = false
    @Namespace private var profileAnimation
    @Namespace private var profileAvatar
    @Namespace private var profileName
    @Namespace private var profileJob
    
    var body: some View {
        VStack {
            if isProfileExpanded {
                expandedProfileView
            } else {
                collapasedProfileView
            }
            videoList
//            Spacer()
        }
    }
    
    var collapasedProfileView: some View {
        HStack {
            profileImage
                .matchedGeometryEffect(id: profileAvatar, in: profileAnimation)
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text("Hello World")
                    .font(.title).bold()
                    .matchedGeometryEffect(id: profileName, in: profileAnimation)
                
                Text("iOS Developer")
                    .foregroundStyle(.secondary)
                    .matchedGeometryEffect(id: profileJob, in: profileAnimation)
            }
            Spacer()
        }
        .padding()
    }
    
    var expandedProfileView: some View {
        VStack {
            profileImage
                .matchedGeometryEffect(id: profileAvatar, in: profileAnimation)
                .frame(width: 130, height: 130)
            
            VStack(alignment: .leading) {
                Text("Hello World")
                    .font(.title).bold()
                    .matchedGeometryEffect(id: profileName, in: profileAnimation)
                
                Text("iOS Developer")
                    .foregroundStyle(.pink)
                    .matchedGeometryEffect(id: profileJob, in: profileAnimation)
                
                Text("In-Depth Exploration of Overlay and Background Modifiers in SwiftUI.")
                    .padding()
            }
        }
        .padding()
    }
    
    var profileImage: some View {
        ZStack {
            Color.mint
            Image(systemName: "person")
                .resizable()
                .scaleEffect(0.5)
                .onTapGesture {
                    withAnimation(.spring(duration: 0.5)) {
                        isProfileExpanded.toggle()
                    }
                }
        }
        .clipShape(.circle)
    }
    
    var videoList: some View {
        List {
            ForEach(0..<10) { index in
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 150)
                        .foregroundStyle(.thickMaterial)
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .foregroundStyle(Color(.systemGray))
                        .frame(width: 50, height: 50)
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .padding(.horizontal)
    }

}

#Preview {
    ProfileView()
}
