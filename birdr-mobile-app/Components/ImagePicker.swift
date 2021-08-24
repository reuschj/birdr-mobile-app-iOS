//
//  ImagePicker.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/24/21.
//

import SwiftUI

// Adapted from https://swiftuirecipes.com/blog/swiftui-image-picker
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode // allows you to dismiss the image picker overlay
    @Binding var selectedImage: UIImage // selected image binding
    @Binding var didSet: Bool // tells if the view was set or cancelled
    var sourceType: SourceType = .photoLibrary
    @Binding var allowsEditing: Bool
    
    typealias SourceType = UIImagePickerController.SourceType
    typealias Context = UIViewControllerRepresentableContext<ImagePicker>
    
    func makeUIViewController(
        context: Context
    ) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.navigationBar.tintColor = .clear
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: Context
    ) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let control: ImagePicker
        
        init(_ control: ImagePicker) {
            self.control = control
        }
        
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                control.selectedImage = image
                control.didSet = true
            }
            control.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker(
            selectedImage: .constant(UIImage(named: "under-construction")!),
            didSet: .constant(false),
            sourceType: .photoLibrary,
            allowsEditing: .constant(false)
        )
            .preferredColorScheme(.dark)
    }
}
