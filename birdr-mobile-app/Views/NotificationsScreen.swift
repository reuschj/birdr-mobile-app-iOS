//
//  NotificationsScreen.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/24/21.
//

import SwiftUI

struct NotificationsScreen: View {
    var body: some View {
        VStack {
            ComingSoonDisplay(
                description: "There are no notifications for now. But there will be soon! This section is still under construction and will be ready in a future release."
            )
        }
    }
}

struct NotificationsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            NavigationView {
                NotificationsScreen()
            }
        }
        .preferredColorScheme(.dark)
    }
}
