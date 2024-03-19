//
//  HomeView.swift
//  Pooper
//
//  Created by Maija Philip on 2/27/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showAddedMessage = false
    
    var body: some View {
        
        NavigationStack {
            
            Color.surface
                .ignoresSafeArea()
                .overlay {
                    ZStack {
                        VStack() {
                            
                            LastWeekLog()
                            
                            Spacer()
                            
                            Image("PooperTop")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                // .frame(width: .infinity)
                                .padding(.top)
                                .offset(y: 10)
                            
                            AddPoop(showAddedMessage: $showAddedMessage)
                            
                            
                        } // Vstack - overarching
                        .padding(.top)
                        
                        if (showAddedMessage) {
                            // popup message for added poop
                            VStack {
                                Image(systemName: "plus")
                                    .font(.system(size: 40.0))
                                    .foregroundStyle(.onSurface)
                                    
                                Text("Added")
                                    .font(.title)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.onSurface)
                            }
                            .padding(40)
                            .background(RoundedRectangle(cornerRadius: 25.0).fill(Color.primaryContainer))
                            .opacity(0.8)
                        }
                        
                        
                    } // Zstack for added message
                    
                } // overlay
            
        } // NavigationStack
        .tint(Color.theme)
        .navigationTitle("")
        
    } // body
} // HomeView

#Preview {
    HomeView().modelContainer(for: Poop.self, inMemory: true)
}

struct AddPoop: View {
    
    @Environment(\.modelContext) private var modelContext
    @Binding var showAddedMessage: Bool
    
    var body: some View {
        
        GeometryReader { metrics in
            VStack {

                /// quick add button
                Button(
                    action: {
                        // add new basic poop
                        Poop.addItem(newPoop: Poop(), modelContext: modelContext)
                        // show added message
                        withAnimation {
                            showAddedMessage = true
                        }

                        withAnimation {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showAddedMessage = false
                            }
                        }
                        
                    },
                    label: {
                        Text("QUICK ADD +")
                            .foregroundStyle(.primaryContainer)
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                            .disabled(showAddedMessage)
                    }) // quick add
                .padding(.vertical)
                
                
                /// add poop button
                ZStack {
                    Circle()
                        .fill(Color.primaryDark)
                        .frame(width: 120.0)
                    
                    NavigationLink(destination: NewPoopView(), label: {
                        Image(systemName: "plus")
                            .font(.system(size: 60.0))
                            .foregroundStyle(.primaryContainer)
                    })
                } // ZStack
                
                Spacer()
            } // VStack Brown
            .padding(.top)
            .frame(
                width: metrics.size.width,
                height: metrics.size.height
            )
            .background(Color.theme)
            .ignoresSafeArea(.all)
        } // GeometryReader
        
    } // body
} // AddPoop

struct LastWeekLog: View {
    
    @State private var pressing = true
    private var daysofweek = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
    private var last7daysPoops: [Bool] = [true, false, false, true, true, true, false]
    
    var body: some View {
        
        VStack {
            
            HStack {
                ForEach(daysofweek, id: \.self) { day in
                    Text(day)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundStyle(Color.theme)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                } // ForEach
                
            } // HStack - days of week
            
            HStack {
                ForEach(last7daysPoops, id: \.self) { poop in
                    Circle()
                        .frame(width: 25)
                        .foregroundStyle(poop ? Color.theme : Color.secondaryVariant)
                        .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3))
                } // ForEach
                
            } // HStack - circles
            .padding()
            .padding(.horizontal)
            .background(Color.surfaceContainer, in: RoundedRectangle(cornerRadius: 25.0))
        }
        
        
        
    } // body
} // LastWeekLog



