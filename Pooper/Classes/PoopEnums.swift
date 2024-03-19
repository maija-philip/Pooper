//
//  PoopEnums.swift
//  Pooper
//
//  Created by Maija Philip on 2/27/24.
//

import Foundation

enum PoopShape: Int, CaseIterable {
    case Pellets, Blocky, Firm, Smooth, SoftPellets, Pudding, Liquid
    
} // PoopShape

enum PoopColor: Int, CaseIterable {
    case black = 0x311300
    case darkbrown = 0x8B5023
    case lightbrown = 0xD08854
    case green = 0x51520C
    case red = 0x8B2323
    case gray = 0xB0B0B0
    case tan = 0xE8BB86
}

enum PoopAmount: Int, CaseIterable {
    case Tiny, Small, Medium, Large, Huge
}
