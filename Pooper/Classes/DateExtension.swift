//
//  DateExtension.swift
//  Pooper
//
//  Created by Maija Philip on 3/17/24.
//

import Foundation


// for comparing dates
extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    } // startofDay
    
    var day: String {
       self.formatted(
            Date.FormatStyle()
                .weekday(.wide)
        )
    } // day
    
    static func isToday(date: Date) -> Bool {
        date.day == Date().day
    }
    
} // Date
