//
//  RemoteImage.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    
    @Published var image: Image? = nil
    private var loadImageCancellable: AnyCancellable?
    
    func load(fromURLString urlString: String) {
        loadImageCancellable = NetworkManager.shared.downloadImage(urlString: urlString)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(_) = completion {
                    self.image = nil
                }
            } receiveValue: { image in
                guard let uiImage = image else {
                    return
                }
                self.image = Image(uiImage: uiImage)
            }
    }
}

struct RemoteImage: View {
    
    var image: Image?
    
    var body: some View {
        image?.resizable() ?? Image(.foodPlaceholder).resizable()
    }
}

struct AppetizerRemoteImage: View {
    
    @StateObject var imageLoader = ImageLoader()
    let urlString: String
    
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear {
                imageLoader.load(fromURLString: urlString)
            }
    }
}
