//
//  AnyImage.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/24/21.
//

import SwiftUI

struct AnyImage: View {
    var name: String
    var label: Text
    var width: CGFloat?
    var height: CGFloat?
    var alignment: Alignment = .center
    var contentMode: ContentMode = .fit
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image(name, label: label)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: width ?? geometry.size.width,
                        height: height ?? geometry.size.height,
                        alignment: alignment
                    )
                    .scaledToFit()
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height,
                alignment: alignment
            )
        }
    }
}

struct AnyImage_Previews: PreviewProvider {
    static var previews: some View {
        AnyImage(
            name: "birdr-logo-icon-only",
            label: Text("Icon")
        )
            .preferredColorScheme(.dark)
    }
}
