//
//  HomeScreen.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/24/21.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack {
            Text("birdr Demo")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
        }
    }
}

struct HomeContent_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .preferredColorScheme(.dark)
    }
}
