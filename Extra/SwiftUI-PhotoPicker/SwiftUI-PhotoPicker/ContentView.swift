//
//  ContentView.swift
//  SwiftUI-PhotoPicker
//
//  Created by CallmeOni on 16/3/2568 BE.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var avatarImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    
    @State private var images: [UIImage] = []
    @State private var photosPickerItems: [PhotosPickerItem] = []
    
    var body: some View {
        VStack {
            profileImage
            PhotosPicker("Select Photos", selection: $photosPickerItems, maxSelectionCount: 3, selectionBehavior: .ordered)
            ScrollView(.vertical) {
                LazyVGrid(columns: [
                    .init(.flexible()),
                    .init(.flexible())
                ]) {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipped()
                            .padding()
                    }
                }
            }
            Spacer()
        }
        .padding(24)
        .onChange(of: photosPickerItem) { oldValue, newValue in
            Task {
                if let photosPickerItem,
                   let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        avatarImage = image
                    }
                }
                photosPickerItem = nil
            }
        }
        .onChange(of: photosPickerItems) { oldValue, newValue in
            Task {
                for item in photosPickerItems {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data) {
                            images.append(image)
                        }
                    }
                }
                photosPickerItems.removeAll()
            }
        }
    }
    
    private var profileImage: some View {
        HStack(spacing: 20) {
            PhotosPicker(selection: $photosPickerItem, matching: .images) {
                ZStack {
                    Color.mint
                    Image(
                        uiImage: (avatarImage ?? UIImage(systemName: "person"))!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaleEffect(avatarImage == nil ? 0.5 : 1)
                }
                .frame(width: 100, height: 100)
                .clipShape(.circle)
            }
            
            VStack(alignment: .leading) {
                Text("John Doe")
                    .font(.headline)
                Text("johndoe@example.com")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
