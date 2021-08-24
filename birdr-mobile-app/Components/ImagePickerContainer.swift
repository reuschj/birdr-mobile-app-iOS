//
//  ImagePickerContainer.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/24/21.
//

import SwiftUI

struct ImagePickerContainer: View {
    var width: CGFloat?
    var height: CGFloat?
    
    @Binding var isSet: Bool
    @Binding var selection: UIImage
    
    @State private var showPopover = false
    @State var allowsEditing: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Button(
                    action: {
                        showPopover.toggle()
                    },
                    label: {
                        Content(
                            width: width,
                            height: height,
                            isSet: $isSet,
                            selection: $selection,
                            showPopover: $showPopover,
                            allowsEditing: $allowsEditing,
                            geometry: geometry
                        )
                    }
                )
            }
        }
    }
    
    struct Content: View {
        var width: CGFloat?
        var height: CGFloat?
        @Binding var isSet: Bool
        @Binding var selection: UIImage
        @Binding var showPopover: Bool
        @Binding var allowsEditing: Bool
        var geometry: GeometryProxy
        var maxHeight: CGFloat { height ?? geometry.size.height }
        var maxWidth: CGFloat { width ?? geometry.size.width }
        var body: some View {
            VStack {
                if isSet {
                    Image(uiImage: selection)
                        .resizable()
                        .frame(maxHeight: maxHeight)
                } else {
                    ZStack {
                        Text("Choose an image")
                            .font(.callout)
                            .foregroundColor(.orange)
                    }
                    .frame(width: maxWidth, height: maxHeight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray)
                    )
                }
            }
            .popover(isPresented: $showPopover) {
                ImagePicker(
                    selectedImage: $selection,
                    didSet: $isSet,
                    allowsEditing: $allowsEditing
                )
            }
        }
    }
}

struct ImagePickerContainer_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerContainer(
            isSet: .constant(false),
            selection: .constant(UIImage(named: "under-construction")!)
        )
        .preferredColorScheme(.dark)
    }
}
