//
//  Day79View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/28.
//

import SwiftUI

// MARK: - Day79View

struct Day79View: View {
  @State private var selectedTab = "One"

  let gradient = LinearGradient(colors: [.blue.opacity(0.3), .green.opacity(0.5)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing)

  var body: some View {
    TabView(selection: $selectedTab) {
      ZStack {
        
        // TabView background
        VStack {
          Spacer()

          Rectangle()
            .fill(.clear)
            .frame(maxHeight: 100)
            .background(gradient)
        }
        .ignoresSafeArea(edges: .bottom)

        VStack {
          Text("You can use a ZStack and put a view behind the tab view too.")
            .padding()
            .frame(maxHeight: .infinity)
        }
        .font(.title2)
      }
      .tabItem {
        Label("fold", systemImage: "folder.fill")
      }
      .tag("fold")

      Text("Tab 2")
        .tabItem {
          Label("star", systemImage: "star")
        }
        .onTapGesture {
          selectedTab = "circle"
        }
        .tag("star")

      Text("Tab 3")
        .tabItem {
          Label("circle", systemImage: "circle")
        }
        .tag("circle")
    }
  }
}

// MARK: - Day79View_Previews

struct Day79View_Previews: PreviewProvider {
  static var previews: some View {
    Day79View()
  }
}
