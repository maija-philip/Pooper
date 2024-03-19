//
//  NewPoopView.swift
//  Pooper
//
//  Created by Maija Philip on 2/27/24.
//

import SwiftUI

struct NewPoopView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // go back via command
    @Environment(\.modelContext) private var modelContext
    
    @State private var isSatisfactory: Bool? = nil
    @State private var shape: PoopShape? = nil
    @State private var amount: PoopAmount? = nil
    @State private var color: PoopColor? = nil
    
    var body: some View {
        
        Color.surface
            .ignoresSafeArea()
            .overlay {
                
            VStack(alignment: .leading) {
                
                ShapePicker(shape: $shape)
                AmountPicker(amount: $amount)
                PoopColorPicker(color: $color)
                SatisfactoryToggle(isSatisfactory: $isSatisfactory)
                
                /// add poop button
                HStack {
                    Spacer()
                    
                    Button(action: {
                        // create new poop with selected details
                        let newpoop = Poop()
                        newpoop.shape = shape
                        newpoop.amount = amount
                        newpoop.color = color
                        newpoop.isSatisfied = isSatisfactory
                        
                        Poop.addItem(newPoop: newpoop, modelContext: modelContext)

                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        ZStack {
                            Circle()
                                .fill(Color.primaryDark)
                                .frame(width: 100.0)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 50.0))
                                .foregroundStyle(.primaryContainer)
                        } // ZStack
                    }) // add poop button
                    Spacer()
                }
                .padding(.vertical)
                
                Spacer() // i want anyspace to be here
                
                /// pooper top image
                GeometryReader { metrics in
                    Image("PooperTop")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: metrics.size.width)
                        .padding(.top)
                }
                .ignoresSafeArea(.all)
                
            } // VStack
            .safeAreaPadding(.horizontal)
            .navigationTitle("")
                
        } // Overlay
        .toolbar(.hidden, for: .tabBar)
        

    } // body
} // NewPoopView
 
#Preview {
    NewPoopView()
        .modelContainer(for: Poop.self, inMemory: true)
}

struct OptionButton: View {
    
    var action: () -> ()
    var icon: String
    var color: Color = .brown
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: icon)
                .tint(color)
                .padding()
                .background(color.opacity(0.2), in: Circle())
        }) // Button
        .padding(4.0)
    } // body
} // OptionButton

struct SatisfactoryToggle: View {
    @Binding var isSatisfactory: Bool?
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                isSatisfactory = true
            }, label: {
                Text("SATISFYING")
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundStyle(.onSurface)
                    .padding()
                    .background(Capsule().fill(isSatisfactory ?? false ? Color.secondaryVariant : Color.surface))
            })
            
            Button(action: {
                isSatisfactory = false
            }, label: {
                Text("NOT SATISFYING")
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundStyle(.onSurface)
                    .padding()
                    .background(Capsule().fill(isSatisfactory ?? true ? Color.surface: Color.secondaryVariant))
            })
            
            Spacer()
        } // Vstack
        
    } // body
} // SatistfactoryToggle


struct PoopColorPicker: View {
    
    @Binding var color: PoopColor?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Color")
                .fontDesign(.rounded)
                .foregroundStyle(.theme)
            
            HStack {
                ForEach(PoopColor.allCases, id: \.rawValue) { item in
                    Button(action: {
                        color = item
                    }, label: {
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color(uiColor: UIColor(rgb: item.rawValue)))
                            .padding(8)
                            .background(Circle().fill( color == item ?  Color.secondaryVariant : Color.surface))
                    })
                    
                } // for each all poop colors
            } // circles Hstack
        } // VStack
        .padding()
        
    } // body
} // ColorPicker

struct AmountPicker: View {
    
    @Binding var amount: PoopAmount?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Amount")
                .fontDesign(.rounded)
                .foregroundStyle(.theme)
            
            HStack {
                ForEach(PoopAmount.allCases, id: \.rawValue) { item in
                    Button(action: {
                        amount = item
                    }, label: {
                        Image("\(item)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                            .padding(8)
                            .background(Capsule().fill( amount == item ?  Color.secondaryVariant : Color.surface))
                        
                    })
                    
                } // for each all poop colors
            } // circles Hstack
        } // VStack
        .padding()
        
    } // body
} // AmountPicker


struct ShapePicker: View {
    
    @Binding var shape: PoopShape?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Shape")
                .fontDesign(.rounded)
                .foregroundStyle(.theme)
            
            HStack {
                ForEach(PoopShape.allCases, id: \.rawValue) { item in
                    if (item != .SoftPellets && item != .Pudding && item != .Liquid) {
                        Button(action: {
                            shape = item
                        }, label: {
                            Image("\(item)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 22)
                                .padding(8)
                                .background(Capsule().fill( shape == item ?  Color.secondaryVariant : Color.surface))
                            
                        }) // button
                    } // if not last 3
                    
                } // for each all poop colors
            } // circles Hstack
            
            // last couple in next row
            HStack {
                /// soft pellets
                Button(action: {
                    shape = .SoftPellets
                }, label: {
                    Image("\(PoopShape.SoftPellets)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 22)
                        .padding(8)
                        .background(Capsule().fill( shape == .SoftPellets ?  Color.secondaryVariant : Color.surface))
                    
                }) // soft pellets button
                
                /// pudding
                Button(action: {
                    shape = .Pudding
                }, label: {
                    Image("\(PoopShape.Pudding)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 22)
                        .padding(8)
                        .background(Capsule().fill( shape == .Pudding ?  Color.secondaryVariant : Color.surface))
                    
                }) // pudding button
                
                /// liquid
                Button(action: {
                    shape = .Liquid
                }, label: {
                    Image("\(PoopShape.Liquid)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 22)
                        .padding(8)
                        .background(Capsule().fill( shape == .Liquid ?  Color.secondaryVariant : Color.surface))
                    
                }) // liquid button
            } // 2nd row Hstack
            
        } // VStack
        .padding([.horizontal, .bottom])
        
    } // body
} // AmountPicker


