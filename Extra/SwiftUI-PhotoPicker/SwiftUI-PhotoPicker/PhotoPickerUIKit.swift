//
//  PhotoPickerUIKit.swift
//  SwiftUI-PhotoPicker
//
//  Created by CallmeOni on 16/3/2568 BE.
//

import SwiftUI

struct PhotoPickerUIKit: UIViewControllerRepresentable {
    
    @Binding var avatarImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinate {
        return Coordinate(photoPicker: self)
    }
    
    final class Coordinate: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let photoPicker: PhotoPickerUIKit
        
        init(photoPicker: PhotoPickerUIKit) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                guard let data = image.jpegData(compressionQuality: 0.1),
                      let compressedImage = UIImage(data: data) else {
                    return
                }
                photoPicker.avatarImage = compressedImage
            }
            picker.dismiss(animated: true)
        }
    }
    
    typealias UIViewControllerType = UIImagePickerController
}
