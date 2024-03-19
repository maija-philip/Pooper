//
//  PooperApp.swift
//  Pooper
//
//  Created by Maija Philip on 2/27/24.
//

import SwiftUI
import SwiftData

@main
struct PooperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Poop.self])
    }
}
