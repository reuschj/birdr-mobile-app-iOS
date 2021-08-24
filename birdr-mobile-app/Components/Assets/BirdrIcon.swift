//
//  BirdrIcon.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/24/21.
//

import SwiftUI

struct BirdrIcon: View {
    var label: Text = Text("birdr Logo")
    var width: CGFloat?
    var height: CGFloat?
    var alignment: Alignment = .center
    var contentMode: ContentMode = .fit
    
    var body: some View {
        AnyImage(
            name: "birdr-logo-icon-only",
            label: label,
            width: width,
            height: height,
            alignment: alignment,
            contentMode: contentMode
        )
    }
}

struct BirdrIcon_Previews: PreviewProvider {
    static var previews: some View {
        BirdrIcon()
            .preferredColorScheme(.dark)
    }
}
