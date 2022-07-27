//
//  ContentView.swift
//  Units
//
//  Created by Suhail Khan on 7/21/22.
//

import SwiftUI

struct ContentView: View {
    @State private var temperature = 73.0
    @State private var unitFrom = "F"
    @State private var unitTo = "C"
    @FocusState private var isFocused: Bool
    
    let units = ["F", "C", "K"]
    
    var convertedTemperature: Double {
        let c: Double
        
        if (unitFrom == "F") {
            c = ((temperature - 32) * 5/9)
        } else if (unitFrom == "K") {
            c = (temperature - 273.15)
        } else {
            c = temperature
        }
        
        switch unitTo {
        case unitFrom:
            return temperature
        case "F":
            return c * 9/5 + 32
        case "C":
            return c
        case "K":
            return c + 273.15
        default:
            return temperature
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature", value: $temperature, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                    Picker("Units", selection: $unitFrom) {
                        ForEach(units, id: \.self) {
                            if ($0 == "K") {
                                Text("\($0)")
                            } else {
                                Text("º \($0)")
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Picker("Convert to", selection: $unitTo) {
                        ForEach(units, id: \.self) {
                            if ($0 == "K") {
                                Text("\($0)")
                            } else {
                                Text("º \($0)")
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert to")
                }
                
                Section {
                    Text(convertedTemperature.formatted(.number.precision(.fractionLength(2))))
                }
            }
            .navigationTitle("Units")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        isFocused = false
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
