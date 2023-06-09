//
//  ContentView.swift
//  Conversion
//
//  Created by Simphiwe Mbokazi on 2023/06/09.
//

import SwiftUI

enum LengthUnit: String, CaseIterable, Identifiable {
    case kilometers = "km"
    case miles = "mi"
    case yards = "yd"
    case feet = "ft"
    case meters = "m"
    
    var id: String { self.rawValue }
}

func convertLength(value: Double, fromUnit: LengthUnit, toUnit: LengthUnit) -> Double {
   
    let conversionFactors: [LengthUnit: Double] = [
        .kilometers: 1000,
        .miles: 1609.34,
        .yards: 0.9144,
        .feet: 0.3048,
        .meters: 1
    ]
    
   
    let valueInMeters = value * conversionFactors[fromUnit]!
    
    
    let convertedValue = valueInMeters / conversionFactors[toUnit]!
    
    return convertedValue
}


struct ContentView: View {
    

    @FocusState private var amountIsFocused: Bool
    
    
    @State private var valueText = ""
       @State private var fromUnit = LengthUnit.kilometers
       @State private var toUnit = LengthUnit.miles
       
       let lengthUnits = LengthUnit.allCases
       
       var convertedValue: Double {
           guard let value = Double(valueText) else { return 0 }
           return convertLength(value: value, fromUnit: fromUnit, toUnit: toUnit)
       }

    
    var body: some View {
        
        NavigationView{
            Form{
                Section{
                    Picker("Units", selection: $fromUnit){
                        ForEach(lengthUnits) { unit in
                           Text(unit.rawValue).tag(unit)
                       }
                    }
                    .pickerStyle(.segmented)
                }
            header: {
                Text("Unit you're converting from")
            }
                Section{
                    Picker("Units To", selection: $toUnit){
                        ForEach(lengthUnits) { unit in
                          Text(unit.rawValue).tag(unit)
                      }
                    }
                    .pickerStyle(.segmented)
                }
            header: {
                Text("Unit you're converting to")
            }

                Section{
                   TextField("Value", text: $valueText)
                       .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }

                Section{
                   Text("\(convertedValue, specifier: "%.2f") \(toUnit.rawValue)")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                }
            }
            .navigationTitle("Conversion")
            .toolbar{
                ToolbarItem(placement: .keyboard){
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
