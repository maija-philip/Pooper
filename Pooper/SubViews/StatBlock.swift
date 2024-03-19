//
//  StatBlock.swift
//  Pooper
//
//  Created by Maija Philip on 3/17/24.
//

import SwiftUI

struct StatBlock: View {
    
    var title: String
    var data: String
    var subtitle: String
    var isSubBold: Bool
    
    var body: some View {
        HStack{
            Spacer()
            
            VStack{
                Text(title)
                    .fontDesign(.rounded)
                    .foregroundStyle(.theme)
                    .bold()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                Text(data)
                    .fontDesign(.rounded)
                    .foregroundStyle(.theme)
                    .bold()
                    .font(.system(size: 60.0))

                Text(subtitle)
                    .fontDesign(.rounded)
                    .foregroundStyle(.theme)
                    .fontWeight(isSubBold ? .bold : .regular)
                    .padding(.bottom)
            } // VStack Overarching
            
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20.0).fill(Color.surfaceContainer))
        
    } // body
} // StatBlock

#Preview {
    StatBlock(title: "Daily Avg", data: "1.2", subtitle: "Poops", isSubBold: false)
}
