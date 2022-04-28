//
//  Day27View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/4/28.
//

import SwiftUI

struct Day27View: View {
    
    @State private var wakeup = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)
                
                DatePicker("Please enter a time",
                           selection: $wakeup,
                           displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Text("Desired amount of sleep")
                    .font(.headline)
                Stepper("\(sleepAmount.formatted()) hours",
                        value: $sleepAmount,
                        in: 0 ... 12,
                        step: 0.25)
                
                Text("Daily coffee intake")
                    .font(.headline)
                Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups",
                        value: $coffeeAmount,
                        in: 1 ... 20)
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
        }
    }
    
    func calculateBedtime() {
        
    }
}

struct Day27View_Previews: PreviewProvider {
    static var previews: some View {
        Day27View()
    }
}
