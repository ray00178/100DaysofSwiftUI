//
//  Day81View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/1.
//

import SwiftUI

// MARK: - Day81View

struct Day81View: View {
  @State private var backgroundColor = Color.red

  var body: some View {
    List {
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
    }

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
