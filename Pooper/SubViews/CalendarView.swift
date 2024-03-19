//
//  CalendarView.swift
//  Pooper
//
//  Created by Maija Philip on 3/8/24.
//  https://www.youtube.com/watch?v=d8KYAeBDQAQ
//

import Foundation
import SwiftUI

struct CalendarView: UIViewRepresentable {
    
    
    typealias UIViewType = UICalendarView
    
    let interval: DateInterval
    @ObservedObject var poops: PoopList
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.delegate = context.coordinator
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        return view
    } // make UI view
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, poops: _poops)
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate {
        
        var parent: CalendarView
        @ObservedObject var poops: PoopList
        
        init(parent: CalendarView, poops: ObservedObject<PoopList>) {
            self.parent = parent
            self._poops = poops
        }
        
        @MainActor // tells it to run on the main thread
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            
            let filteredpoops = poops.poops.filter { $0.timestamp.startOfDay == dateComponents.date?.startOfDay}
            
            // no poops
            if (filteredpoops.isEmpty) {
                return nil
            }
            
            return .image(UIImage(systemName: "Blocky"), color: UIColor.theme, size: .large)
        } // calendar view func
        
    } // Coordinator class
    
} // CalendarView struct
