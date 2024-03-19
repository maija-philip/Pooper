//
//  ThisWeekPoopsView.swift
//  Pooper
//
//  Created by Maija Philip on 3/17/24.
//

import SwiftUI
import SwiftData

struct ThisWeekPoopsView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Poop.timestamp, order: .reverse) var poopsOrdered: [Poop]
    
    @State var showsAlert = false
    @State var poopToDelete: Poop? = nil
    
    var body: some View {
        
        HStack {
            Spacer()
            VStack(alignment: .center) {
                
                // Header
                HStack {
                    Text("This Week")
                        .fontDesign(.rounded)
                        .bold()
                        .foregroundStyle(.theme)
                    Spacer()
                    // link to new poop view
                    NavigationLink(destination: NewPoopView(), label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.theme)
                            .font(.title2)
                    })
                } // Header
                .padding(.bottom)
                    
                // if no poops
                if (poopsOrdered.isEmpty) { // TODO: poops

                    Text("No poops so far")
                        .fontDesign(.rounded)
                        .foregroundStyle(Color.theme)
                        .padding(.bottom)
                        .padding(.bottom)

                    
                } else {
                    
                    // have poops
                    ForEach(poopsOrdered) { poop in
                                                
                        VStack{
                            if (poop.hasData()) {
                                
                                DataRow(poop: poop)
                                
                            } else {
                                // no poop data
                                NoDataRow(poop: poop)
                                
                            } // else poop has data
                        } // list item
                        .gesture(
            //                TapGesture()
            //                    .onEnded({
            //                        isPressed.toggle()
            //                    })
                            LongPressGesture(minimumDuration: 0.5)
                                .onEnded({ _ in
                                    poopToDelete = poop
                                    self.showsAlert.toggle()
                                })
                        ) // gesture
                    } // ForEach
                    .alert("Do you want to delete this poop?", isPresented: $showsAlert){
                            Button(role: .destructive) {
                                if let poopy = poopToDelete {
                                    modelContext.delete(poopy)
                                    poopToDelete = nil
                                }
                            } label: {
                                Text("Delete")
                            } // Delete Button

                        } // Alert
                    
                } // else has poops
                
                
            } // overarching vstack
            Spacer()
        } // make it full width
        .padding()
        //.frame(minHeight: 120)
        .background(RoundedRectangle(cornerRadius: 20.0).fill(Color.surfaceContainer))
        
        
    } // body
    
} // this weeks poops



#Preview {
    MainActor.assumeIsolated {
        ThisWeekPoopsView()
            .modelContainer(previewContainer)
    }
}


struct DataRow: View {
    @State var poop: Poop
    
    var body: some View {
        HStack {
            
            if (!poop.hasFullData()) {
                Text(Date.isToday(date: poop.timestamp) ? "Today": poop.getDayAbbreviation())
                    .fontDesign(.rounded)
                    .foregroundStyle(Color.theme)
                    .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
                Spacer()
            }
                 
            if poop.shape != nil {
                Image("\(poop.shape ?? .Firm)")
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 40)
                     .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
            } // if poop shape exists
            
            Spacer()
                
            if poop.amount != nil {
                Image("\(poop.amount ?? .Medium)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                    .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
            } // if poop shape exists
            
            Spacer()
                
            if poop.color != nil {
                Circle()
                    .foregroundStyle(Color(uiColor: UIColor(rgb: poop.color?.rawValue ?? PoopColor.darkbrown.rawValue)))
                    .frame(height: 30)
                    .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
            } // if poop shape exists
            
                 
            
        } // HStack
        .frame(height: 50)
        .background(Capsule().fill(Color.secondaryVariant))
    } // body
} // DataRow

struct NoDataRow: View {
    
    @State var poop: Poop
    
    var body: some View {
        HStack() {
            
            Text(Date.isToday(date: poop.timestamp) ? "Today" : "\(poop.timestamp.day)")
                .fontDesign(.rounded)
                .foregroundStyle(Color.theme)
                .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
            
            Spacer()
            
            Image("PooperTop")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 25))
            
        }
        .frame(height: 50)
        .background(Capsule().fill(Color.secondaryVariant))
    }
}



