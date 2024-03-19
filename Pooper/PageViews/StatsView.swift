//
//  StatsView.swift
//  Pooper
//
//  Created by Maija Philip on 2/27/24.
//

import SwiftUI
import SwiftData

struct StatsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Poop.timestamp, order: .reverse) var poopsOrdered: [Poop]
    
    
    var body: some View {
        
        NavigationStack {
            Color.surface
                .ignoresSafeArea()
                .overlay {
                    
                    ScrollView {
                        VStack{
                            ThisWeekPoopsView()
                                
                            HStack(alignment: .top) {
                                // TODO: actual value
                                StatBlock(title: "Daily Avg", data: "1.2", subtitle: "Poops", isSubBold: false)
                                
                                Rectangle()
                                    .frame(width: 10)
                                    .foregroundStyle(.surface)
                                
                                // TODO: actual value
                                StatBlock(title: "Monthly Avg", data: "22", subtitle: "Poops", isSubBold: false)
                            } // HStack daily + monthly avg
                            .padding(.top)
                            
                            HStack(alignment: .top)  {
                                // TODO: actual value
                                StatBlock(title: "", data: "55%", subtitle: "Satisfied", isSubBold: true)
                                
                                Spacer()
                            } // HStack satisfyied + streaks
                            .padding(.top)
                            
                        
                            Spacer()
                        } // VStack
                } // ScrollView
                .scrollIndicators(.hidden)
                .safeAreaPadding(.horizontal)
                .navigationTitle("")
                    
            } // Overlay
        } // navigation stack
        .tint(Color.theme)
        .navigationTitle("")
        
        
        
    } // body
} // StatsView

#Preview {
    MainActor.assumeIsolated {
        StatsView()
            .modelContainer(previewContainer)
    }
}
