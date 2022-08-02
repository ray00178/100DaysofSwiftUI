//
//  Day81View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/1.
//

import SwiftUI
import UserNotifications
import SamplePackage

// MARK: - Day81View

struct Day81View: View {
  @State private var backgroundColor = Color.red
  
  let possibleNumbers = Array(1...60)
  
  var result: String {
    let selected = possibleNumbers.random(7).sorted()
    let strings = selected.map(String.init)
    return strings.joined(separator: ", ")
  }
  
  var body: some View {
    
    VStack(spacing: 20) {
      Button("Request Permission") {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
          if success {
            print("Success")
          } else if let error = error {
            print(error.localizedDescription)
          }
        }
      }
      .padding()
      
      Button("Scedule Notification") {
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
      }
      .padding()
      
      Text(result)
    }
    
    
    //
    /*List {
      Text("Taylor Swift")
        .swipeActions {
          Button(role: .destructive) {
            print("Hi")
          } label: {
            Label("Delete", systemImage: "music.circle")
          }
        }
        .swipeActions(edge: .leading) {
          Button {
            print("Hi")
          } label: {
            Label("Pin", systemImage: "pin")
          }
          .tint(.orange)
        }
    }*/

    // Creating context menus
    /* VStack {
       Text("Hello world")
         .padding()
         .background(backgroundColor)

       Text("Change Color")
         .padding()
         .contextMenu {
           Button(role: .destructive) {
             backgroundColor = .red
           } label: {
             Label("Red", systemImage: "checkmark.circle.fill")
           }

           Button(role: .destructive) {
             backgroundColor = .blue
           } label: {
             Label("Blue", systemImage: "checkmark.circle.fill")
           }

           Button(role: .destructive) {
             backgroundColor = .green
           } label: {
             Label("Green", systemImage: "checkmark.circle.fill")
           }
         }
     } */
  }
}

// MARK: - Day81View_Previews

struct Day81View_Previews: PreviewProvider {
  static var previews: some View {
    Day81View()
  }
}
