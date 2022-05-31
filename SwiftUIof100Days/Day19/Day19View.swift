//
//  Day19View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/4/20.
//

import SwiftUI

struct Day19View: View {
    
    @State private var input = 100.0
    @State private var inputUnit: Dimension = UnitLength.meters
    @State private var outputUnit: Dimension = UnitLength.kilometers
    
    @FocusState private var inputFocus: Bool
    
    let units: [Dimension] = [UnitLength.meters,
                              UnitLength.kilometers,
                              UnitLength.feet,
                              UnitLength.yards,
                              UnitLength.miles]
    
    let formatter: MeasurementFormatter
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
        formatter.locale = Locale.current
    }
    
    var result: String {
        let inputLength = Measurement(value: input, unit: inputUnit)
        let outputLength = inputLength.converted(to: outputUnit)
        return formatter.string(from: outputLength)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputFocus)
                } header: {
                    Text("Amount to convert")
                }
                
                Picker("Convert from", selection: $inputUnit) {
                    ForEach(units, id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
                    }
                }
                
                Picker("Convert to", selection: $outputUnit) {
                    ForEach(units, id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
                    }
                }
                
                Section {
                    Text(result)
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputFocus = false
                    }
                }
            }
        }
    }
}

struct Day19_Previews: PreviewProvider {
    static var previews: some View {
        Day19View()
    }
}
