//
//  Day16View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/4/18.
//

import SwiftUI

struct Day16View: View {
    
    @State private var conut: Int = 0
    
    @State private var name: String = ""
    
    private let students: [String] = ["Ray", "Aida", "John"]
    @State private var selectedStudent = "Ray"
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Hello 1")
                    Text("Hello 2")
                    Text("Hello 3")
                    Text("Hello 4")
                    TextField("Enter your name", text: $name)
                    Text("My name is \(name)")
                        .foregroundColor(.blue)
                    Picker("Select student", selection: $selectedStudent) {
                        ForEach(students, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                Section {
                    Text("Hello 5")
                    Text("Hello 6")
                    Text("Hello 7")
                    Text("Hello 8")
                    Button {
                        conut += 1
                    } label: {
                        Text("Tap me count = \(conut)")
                    }

                }
            }
            .navigationTitle("Swift UI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Day16View_Previews: PreviewProvider {
    static var previews: some View {
        Day16View()
    }
}
