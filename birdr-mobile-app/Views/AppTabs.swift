//
//  AppTabs.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/24/21.
//

import SwiftUI

struct AppTabs: View {
    
    @Binding var tabSelection: Tab
    
    enum Tab: Int, Hashable {
        case home
        case spottings
        case notifications
        case settings
        
        var tabTitle: LocalizedStringKey {
            switch self {
            case .home:
                return "Home"
            case .spottings:
                return "Spottings"
            case .notifications:
                return "Notifications"
            case .settings:
                return "Settings"
            }
        }
        
        var tabIcon: String {
            switch self {
            case .home:
                return "house"
            case .spottings:
                return "binoculars"
            case .notifications:
                return "bell"
            case .settings:
                return "gearshape"
            }
        }
    }
    
    var body: some View {
        TabView {
            // 🏠 Home screen ---------------------------/
            NavigationView {
                HomeScreen()
                    .navigationBarTitle(Text(Tab.home.tabTitle))
                    .navigationBarTitleDisplayMode(.large)
                    .navigationViewStyle(DefaultNavigationViewStyle())
            }
            .tabItem {
                Image(systemName: Tab.home.tabIcon)
                Text(Tab.home.tabTitle)
            }
            .tag(Tab.home)
            
            // 🦜 Spottings screen ----------------------/
            NavigationView {
                SpottingsScreen()
                    .navigationBarTitle(Text(Tab.spottings.tabTitle))
                    .navigationBarTitleDisplayMode(.large)
                    .navigationViewStyle(DefaultNavigationViewStyle())
            }
            .tabItem {
                Image(systemName: Tab.spottings.tabIcon)
                Text(Tab.spottings.tabTitle)
            }
            .tag(Tab.spottings)
            
            // 🔔 Notifiations screen ----------------------/
            NavigationView {
                NotificationsScreen()
                    .navigationBarTitle(Text(Tab.notifications.tabTitle))
                    .navigationBarTitleDisplayMode(.large)
                    .navigationViewStyle(DefaultNavigationViewStyle())
            }
            .tabItem {
                Image(systemName: Tab.notifications.tabIcon)
                Text(Tab.notifications.tabTitle)
            }
            .tag(Tab.notifications)
            
            // ⚙️ Settings screen ----------------------/
            NavigationView {
                SettingsScreen()
                    .navigationBarTitle(Text(Tab.settings.tabTitle))
                    .navigationBarTitleDisplayMode(.large)
                    .navigationViewStyle(DefaultNavigationViewStyle())
            }
            .tabItem {
                Image(systemName: Tab.settings.tabIcon)
                Text(Tab.settings.tabTitle)
            }
            .tag(Tab.settings)
        }
    }
}

struct AppTabs_Previews: PreviewProvider {
    static var previews: some View {
        AppTabs(tabSelection: .constant(.home))
            .preferredColorScheme(.dark)
    }
}
