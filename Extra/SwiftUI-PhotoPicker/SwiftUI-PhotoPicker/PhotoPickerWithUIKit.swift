//
//  PhotoPickerWithUIKit.swift
//  SwiftUI-PhotoPicker
//
//  Created by CallmeOni on 16/3/2568 BE.
//

import SwiftUI

struct PhotoPickerWithUIKit: View {
    
    @State private var avatarImage: UIImage?
    @State private var isShowingPhotoPicker = false
    
    var body: some View {
        VStack {
            ZStack {
                Color.mint
                Image(
                    uiImage: (avatarImage ?? UIImage(systemName: "person"))!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(avatarImage == nil ? 0.5 : 1)
                    .onTapGesture {
                        isShowingPhotoPicker = true
                    }
            }
            .frame(width: 100, height: 100)
            .clipShape(.circle)
            Spacer()
        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPickerUIKit(avatarImage: $avatarImage)
        }
    }
}

#Preview {
    PhotoPickerWithUIKit()
}
