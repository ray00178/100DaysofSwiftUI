//
//  Day27View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/4/28.
//

import SwiftUI
import CoreML

struct Day27View: View {
    
    @State private var wakeup = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var compoents = DateComponents()
        compoents.hour = 7
        compoents.minute = 0
        return Calendar.current.date(from: compoents) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time",
                               selection: $wakeup,
                               displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours",
                            value: $sleepAmount,
                            in: 0 ... 12,
                            step: 0.25)
                }
                
                Section("Daily coffee intake") {
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups",
                            value: $coffeeAmount,
                            in: 1 ... 20)
                }
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
              Text(alertMessage)
            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeup)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount))
            let sleepTime = wakeup - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
    }
}

struct Day27View_Previews: PreviewProvider {
    static var previews: some View {
        Day27View()
    }
}
