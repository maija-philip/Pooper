//
//  Poop.swift
//  Pooper
//
//  Created by Maija Philip on 2/27/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Poop: ObservableObject {
    var timestamp: Date
    var isSatisfied: Bool?
    
    // shape
    @Attribute(originalName: "shape") var shapeNum: PoopShape.RawValue? = nil
    var shape: PoopShape? {
        get { shapeNum != nil ? PoopShape(rawValue: shapeNum ?? 2) : nil }
        set { shapeNum = newValue?.rawValue}
    }
    
    // color
    @Attribute(originalName: "color") var colorInt: PoopColor.RawValue? = nil
    var color: PoopColor? {
        get { colorInt != nil ? PoopColor(rawValue: colorInt ?? 0x8B5023) : nil }
        set { colorInt = newValue?.rawValue }
    }
    
    // amount
    @Attribute(originalName: "amount") var amountInt: PoopAmount.RawValue? = nil
    var amount: PoopAmount? {
        get { amountInt != nil ? PoopAmount(rawValue: amountInt ?? 2) : nil }
        set { amountInt = newValue?.rawValue }
    }
    
    init() {
        self.timestamp = Date()
    }
    
    convenience init(timestamp: Date) {
        self.init()
        self.timestamp = timestamp
    }
    
    convenience init(timestamp: Date, isSatisfied: Bool?, shape: PoopShape?, color: PoopColor?, amount: PoopAmount?) {
        self.init()
        self.timestamp = timestamp
        self.isSatisfied = isSatisfied
        self.shape = shape
        self.color = color
        self.amount = amount
    }
    
    public func hasData() -> Bool {
        return shape != nil || amount != nil || color != nil
    }
    
    public func hasFullData() -> Bool {
        return shape != nil && amount != nil && color != nil
    }
    
    public func getDayAbbreviation() -> String {
        return timestamp.formatted(
            Date.FormatStyle()
                .weekday(.short)
        )
    }
    
    public func getDayFull() -> String {
        return timestamp.formatted(
            Date.FormatStyle()
                .weekday(.wide)
        )
    }
    
} // Poop

// static model manipulation
extension Poop {
    
    public static func addItem(newPoop: Poop, modelContext: ModelContext) {
        withAnimation {
            modelContext.insert(newPoop)
        }
    } // addItem

    public static func deleteItems(offsets: IndexSet, modelContext: ModelContext, items: [Poop]) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    } // deleteItems
    
} // Poop extension


// For the calendarview
class PoopList: ObservableObject {
    var poops: [Poop]
    
    init(poops: [Poop]) {
        self.poops = poops
    }
}
