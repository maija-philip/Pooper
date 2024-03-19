//
//  Test.swift
//  Pooper
//
//  Created by Maija Philip on 3/18/24.
//

import SwiftUI
import SwiftData

struct Test: View {
    
    @Query(sort: \Poop.timestamp, order: .reverse) var poopsOrdered: [Poop]
    
    var body: some View {
        VStack(alignment: .center) {

            // so swipe works
            List() {
            
                // have poops
                ForEach(poopsOrdered) { poop in
                    
                    VStack{
                       Text("hi")
                    } // list item
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                } // ForEach
                
            
            } // list
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            
            
        } // overarching vstack
        .padding()
        .background(RoundedRectangle(cornerRadius: 20.0).fill(Color.surfaceContainer))
        
    }
}

#Preview {
    MainActor.assumeIsolated {
        Test()
            .modelContainer(previewContainer)
    }
}

