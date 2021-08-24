//
//  SettingsScreen.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/24/21.
//

import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        VStack {
            ComingSoonDisplay(
                description: "There are no settings for now. But there will be soon! This section is still under construction and will be ready in a future release."
            )
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
        
    }
}
