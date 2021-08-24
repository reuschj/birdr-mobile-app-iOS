//
//  UnderConstructionLogo.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/24/21.
//

import SwiftUI

struct UnderConstructionLogo: View {
    var label: Text = Text("Under Construction")
    var width: CGFloat?
    var height: CGFloat?
    var alignment: Alignment = .center
    var contentMode: ContentMode = .fit
    
    var body: some View {
        AnyImage(
            name: "under-construction",
            label: label,
            width: width,
            height: height,
            alignment: alignment,
            contentMode: contentMode
        )
    }
}

struct UnderConstructionLogo_Previews: PreviewProvider {
    static var previews: some View {
        UnderConstructionLogo()
            .preferredColorScheme(.light)
    }
}
