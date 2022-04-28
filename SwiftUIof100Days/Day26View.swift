//
//  Day26View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/4/27.
//

import SwiftUI

struct Day26View: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeup = Date.now
    
    
    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) house",
                    value: $sleepAmount,
                    in: 4...12,
                    step: 2.5)
            
            Stepper("\(sleepAmount.formatted()) house") {
                sleepAmount += 1.0
            } onDecrement: {
                sleepAmount -= 2.0
            }
            
            DatePicker("Please enter a date",
                       selection: $wakeup,
                       in: Date.now...,
                       displayedComponents: .date)
            
            Text(Date.now, format: .dateTime.hour().minute())
            Text(Date.now, format: .dateTime.day().month().year())
            Text(Date.now.formatted(date: .long, time: .complete))
            
        }
        .padding([.leading, .trailing], 20.0)
    }
}

struct Day24View_Previews: PreviewProvider {
    static var previews: some View {
        Day26View()
    }
}
