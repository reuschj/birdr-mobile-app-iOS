//
//  ContentView.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/23/21.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection: AppTabs.Tab = .home
    var body: some View {
        AppTabs(tabSelection: $tabSelection)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
