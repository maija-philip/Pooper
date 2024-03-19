//
//  CalendarPageView.swift
//  Pooper
//
//  Created by Maija Philip on 2/27/24.
//

import SwiftUI
import SwiftData

struct CalendarPageView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var poops: [Poop]
    
    var body: some View {
        Color.surface
            .ignoresSafeArea()
            .overlay {
                VStack {
                    
                    CalendarView(interval: DateInterval(start: .distantPast, end: .now), poops: PoopList(poops: poops))
                        .tint(Color.theme)
                    
                    
                } // VStack
                .safeAreaPadding(.all)
            } // Overlay
    } // body
} // CalendarView

#Preview {
    MainActor.assumeIsolated {
        CalendarPageView()
            .modelContainer(previewContainer)
    }
}
