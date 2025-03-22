//
//  ImagePreviewView.swift
//  SwiftUIAnimation
//
//  Created by CallmeOni on 13/3/2568 BE.
//

import SwiftUI

struct ImagePreviewView: View {
    
    @Namespace private var previewSmoothly
    @State private var preview = false
    @State private var selectedImageName: String?
    
    var body: some View {
        ZStack {
            if preview {
                if let haveImage = selectedImageName {
                    createImage(haveImage)
                        .ignoresSafeArea()
                }
            } else {
                Grid {
                    GridRow {
                        createImage("image1")
                        createImage("image2")
                    }
                    
                    GridRow {
                        createImage("image3")
                    }
                }
                .padding(10)
            }
        }
    }
    
    func createImage(_ imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .matchedGeometryEffect(id: imageName, in: previewSmoothly)
            .zIndex(selectedImageName == imageName ? 1 : 0)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 1)) {
                    selectedImageName = imageName
                    preview.toggle()
                }
            }
    }
}

#Preview {
    ImagePreviewView()
}
