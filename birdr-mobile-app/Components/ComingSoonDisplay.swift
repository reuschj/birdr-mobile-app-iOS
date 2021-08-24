//
//  ComingSoonDisplay.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/24/21.
//

import SwiftUI

struct ComingSoonDisplay: View {
    var title: LocalizedStringKey = "Coming Soon!"
    var description: LocalizedStringKey = "This section is under construction"
    var titleFont: Font = .title
    var titleWeight: Font.Weight = .regular
    var titleColor: Color = .orange
    var descriptionFont: Font = .body
    var descriptionColor: Color = .primary
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                UnderConstructionLogo()
                    .padding(32)
                Text(title)
                    .font(titleFont)
                    .fontWeight(.regular)
                    .foregroundColor(titleColor)
                Spacer()
                Text(description)
                    .font(descriptionFont)
                    .foregroundColor(descriptionColor)
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}

struct ComingSoonDisplay_Previews: PreviewProvider {
    static var previews: some View {
        ComingSoonDisplay()
            .preferredColorScheme(.dark)
    }
}
