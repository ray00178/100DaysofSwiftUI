//
//  BookwormContentView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/14.
//

import SwiftUI

// MARK: - BookwormContentView

struct BookwormContentView: View {
  
  @State private var rememberMe: Bool = false
  
  @AppStorage("note") private var note = ""
  
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
  
  var body: some View {
    
    /*VStack {
      List(students) { (student) in
        Text(student.name ?? "Unknown")
      }
      
      Button("Add") {
        let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
        let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

        let chosenFirstName = firstNames.randomElement()!
        let chosenLastName = lastNames.randomElement()!
        
        let student = Student(context: moc)
        student.id = UUID()
        student.name = "\(chosenFirstName) \(chosenLastName)"
        
        try? moc.save()
      }
    }*/
    
    //
    /*NavigationView {
      TextEditor(text: $note)
        .navigationTitle("Notes")
        .padding()
    }*/
    
    // Creating a custom component with @Binding
    VStack {
      PushButton(title: "Remember Me", isOn: $rememberMe)
      Text(rememberMe ? "On" : "Off")
    }
  }
}

// MARK: - BookwormContentView_Previews

struct BookwormContentView_Previews: PreviewProvider {
  static var previews: some View {
    BookwormContentView()
  }
}

// MARK: - PushButton

struct PushButton: View {
  let title: String

  @Binding var isOn: Bool

  var onColors = [Color.red, Color.yellow]
  var offColors = [Color(white: 0.6), Color(white: 0.4)]

  var body: some View {
    Button(title) {
      isOn.toggle()
    }
    .padding()
    .background(.linearGradient(Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
    .foregroundColor(.white)
    .clipShape(Capsule())
    .shadow(radius: isOn ? 0 : 5)
  }
}
