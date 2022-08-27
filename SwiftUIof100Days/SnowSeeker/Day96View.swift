//
//  Day96View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/25.
//

import SwiftUI

// MARK: - Day96View

struct Day96View: View {
  @State private var selectedUser: Day96User?
  @State private var isShowingUser = false
  @State private var searchText: String = ""

  @Environment(\.horizontalSizeClass) var horizontalSizeClass

  let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]

  var filteredNames: [String] {
    if searchText.isEmpty {
      return allNames
    } else {
      return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
  }

  var body: some View {
    // Making a SwiftUI view searchable
    NavigationView {
      List(filteredNames, id: \.self) { name in
        Text(name)
      }
      .searchable(text: $searchText, prompt: "Input some key word...")
      .navigationTitle("Searching")
    }

    // Using groups as transparent layout containers
    /* if horizontalSizeClass == .compact {
       VStack(spacing: 8.0) {
         ForEach(0 ..< 10) { _ in
           DemoView()
         }
       }
     } else {
       HStack(spacing: 8.0) {
         ForEach(0 ..< 10) { _ in
           DemoView()
         }
       }
     } */

    // Using alert() and sheet() with optionals
    /* Text("Hi Friends~")
     .onTapGesture {
       selectedUser = Day96User()
       isShowingUser = true
     }
     .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
       Button(user.id) {}
     }
     .alert("Welcome", isPresented: $isShowingUser) {}
     .sheet(isPresented: $isShowingUser) {
       Text(selectedUser?.id ?? "Unknown")
     }
     .sheet(item: $selectedUser) { user in
       Text("\(user.id)")
     } */

    // Working with two side by side views in SwiftUI
    /* NavigationView {
       NavigationLink {
         if #available(iOS 16.0, *) {
           Text("New secondary")
             .toolbar(.hidden)
         } else {
           Text("New secondary")
             .navigationBarHidden(true)
         }
       } label: {
         Text("Hello, World!")
       }
       .navigationTitle("Primary")
     }

     Text("Secondary") */
  }

  @ViewBuilder
  func DemoView() -> some View {
    HStack(spacing: 12.0) {
      Image(systemName: "moon.stars.fill")
      Text("Moon")
        .font(.subheadline)
        .foregroundColor(.gray)
    }
    .font(.largeTitle)
    .foregroundColor(.yellow)
  }
}

// MARK: - Day96View_Previews

struct Day96View_Previews: PreviewProvider {
  static var previews: some View {
    Day96View()
  }
}
