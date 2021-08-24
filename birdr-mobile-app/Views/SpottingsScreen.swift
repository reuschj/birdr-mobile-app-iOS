//
//  SpottingsScreen.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/24/21.
//

import SwiftUI

struct SpottingsScreen: View {
    var body: some View {
        VStack {
            ComingSoonDisplay(
                title: "Work in Progress",
                description: "This will show a scrolling feed of all posted bird spotting.",
                titleColor: .green
            )
        }
        .navigationBarItems(
            trailing: VStack {
                NavigationLink(
                    destination: AddSpottingScreen(),
                    label: {
                        Text("Add Bird")
                    })
            }
        )
    }
}

struct SpottingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpottingsScreen()
        }
            .preferredColorScheme(.dark)
    }
}
