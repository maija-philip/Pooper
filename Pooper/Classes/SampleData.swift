//
//  SampleData.swift
//  Pooper
//
//  Created by Maija Philip on 3/8/24.
//

import Foundation
import SwiftUI
import SwiftData

class SampleData {
    
    static var contents: [Poop] {
        [
            Poop(timestamp: Date.now.addingTimeInterval(-200000)),
            Poop(timestamp: Date.now.addingTimeInterval(-100000), isSatisfied: true, shape: .Blocky, color: .black, amount: .Huge),
            Poop(timestamp: Date.now.addingTimeInterval(-400000), isSatisfied: false, shape: .Pellets, color: nil, amount: .Small),
            Poop(timestamp: Date.now.addingTimeInterval(-700000), isSatisfied: nil, shape: nil, color: .darkbrown, amount: .Medium),
            Poop(timestamp: Date(), isSatisfied: true, shape: .Smooth, color: .darkbrown, amount: .Medium),
            Poop()
        ]
    }
} // Sample Data

@MainActor
let previewContainer: ModelContainer = {
    
    do {
        
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Poop.self, configurations: config)
        for item in SampleData.contents {
            container.mainContext.insert(item)
        }
        return container
        
    } catch {
        fatalError("Failed to create container")
    }
    
}() // preview Container
