//
//  ContentView.swift
//  UnitConversions
//
//  Created by Conner Shannon on 10/11/19.
//  Copyright © 2019 Conner Shannon. All rights reserved.
//

import SwiftUI

protocol MyUnitProtocol {
    var name: String { get }
    var options: [(label: String, value: Dimension)] { get }
}

struct Temperature: MyUnitProtocol {
    var name = "Temperature"
    var options: [(label: String, value: Dimension)] = [
        (label: "Celcius", value: UnitTemperature.celsius),
        (label: "Fahrenheit", value: UnitTemperature.fahrenheit),
        (label: "Kelvin", value: UnitTemperature.kelvin)
    ]
}

struct Length: MyUnitProtocol {
    var name = "Length"
    var options: [(label: String, value: Dimension)] = [
        (label: "Meters", value: UnitLength.meters),
        (label: "Kilometers", value: UnitLength.kilometers),
        (label: "Feet", value: UnitLength.feet),
        (label: "Yards", value: UnitLength.yards),
        (label: "Miles", value: UnitLength.miles)
    ]
}

struct Time: MyUnitProtocol {
    var name = "Time"
    var options: [(label: String, value: Dimension)] = [
        (label: "Seconds", value: UnitDuration.seconds),
        (label: "Minutes", value: UnitDuration.minutes),
        (label: "Hours", value: UnitDuration.hours)
    ]
}

struct Volume: MyUnitProtocol {
    var name = "Volume"
    var options: [(label: String, value: Dimension)] = [
        (label: "Milliliters", value: UnitVolume.milliliters),
        (label: "Liters", value: UnitVolume.liters),
        (label: "Cups", value: UnitVolume.cups),
        (label: "Pints", value: UnitVolume.pints),
        (label: "Gallons", value: UnitVolume.gallons)
    ]
}



struct ContentView: View {
    let units: [MyUnitProtocol] = [Temperature(), Length(), Time(), Volume()]
    @State private var unitSelection = 0
    @State private var inputSelection = 0
    @State private var input = ""
    @State private var outputSelection = 0
    
    var inputText: Double {
        return Double(input) ?? 0.00
    }
    
    var output: Double {
        let inputValue = Double(input) ?? 0
        let inputMeasurement = Measurement(value: inputValue, unit: units[unitSelection].options[inputSelection].value)
        let outputMeasurement = inputMeasurement.converted(to: units[unitSelection].options[outputSelection].value)
        
        return outputMeasurement.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Unit", selection: $unitSelection) {
                    ForEach(0..<units.count) {
                        Text("\(self.units[$0].name)")
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                Picker("Convert from", selection: $inputSelection) {
                    ForEach(0..<units[unitSelection].options.count) {
                        Text("\(self.units[self.unitSelection].options[$0].label)")
                    }
                }
                
                TextField("Enter \(units[unitSelection].options[inputSelection].label.lowercased())", text: $input)
                
                Picker("Convert to", selection: $outputSelection) {
                    ForEach(0..<units[unitSelection].options.count) {
                        Text("\(self.units[self.unitSelection].options[$0].label)")
                    }
                }
                
                Text("\(inputText, specifier: "%.2f") \(units[unitSelection].options[inputSelection].label.lowercased()) is equal to \(output, specifier: "%.2f") \(units[unitSelection].options[outputSelection].label.lowercased())")
                
            }
            .navigationBarTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
