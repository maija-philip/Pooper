//
//  ContentView.swift
//  Pooper
//
//  Created by Maija Philip on 2/27/24.
//

import SwiftUI
import SwiftData

enum Tabs: Hashable {
    case home
    case calendar
    case stats
    case user
}

struct ContentView: View {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(resource: ColorResource.secondaryVariant)
    }
    
    @State private var selectedTab = Tabs.home
    
    var body: some View {
        
        ZStack {
            TabView(selection: $selectedTab) {
                
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag(Tabs.home)
                StatsView()
                    .tabItem {
                        Image(systemName: "chart.xyaxis.line")
                    }
                    .tag(Tabs.stats)
                CalendarPageView()
                    .tabItem {
                        Image(systemName: "calendar")
                    }
                    .tag(Tabs.calendar)
            
            } // tab view
            .tint(selectedTab == Tabs.home ? .primaryContainer : .theme)
            
            if (selectedTab == Tabs.stats) {
                VStack{
                    Spacer()
                    RoundedRectangle(cornerRadius: 20.0)
                        .frame(maxWidth: .infinity, maxHeight: 10)
                        .foregroundColor(.surface)
                        .padding(.bottom, 49)
                } // vstack
            } // if tab is stats
            
        } // ZStack
        
        
    } // body
} // ContentView

#Preview {
    MainActor.assumeIsolated {
        ContentView()
            .modelContainer(previewContainer)
    }
}
