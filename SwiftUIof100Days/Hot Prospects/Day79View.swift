//
//  Day79View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/28.
//

import SwiftUI

// MARK: - Day79View

struct Day79View: View {
  @StateObject private var updater = DelayerUpdater()
  @State private var selectedTab = "One"
  @State private var output = ""

  let gradient = LinearGradient(colors: [.blue.opacity(0.3), .green.opacity(0.5)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing)

  var body: some View {
    ZStack {
      Image("example")
        .interpolation(.none)
        .resizable()
        .scaledToFit()
        .frame(maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
      
      
      Text(output)
        .task {
          await fetchReadings()
        }
        .font(.headline)
        .foregroundColor(.white)
    }
    

    // Text("Value is \(updater.value)")

    /* TabView(selection: $selectedTab) {
       ZStack {

         // TabView background
         VStack {
           Spacer()

           Rectangle()
             .fill(.clear)
             .frame(maxHeight: 90)
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
     } */
  }

  func fetchReadings() async {
    let fetchTask = Task { () -> String in
      let url = URL(string: "https://hws.dev/readings.json")!
      let (data, _) = try await URLSession.shared.data(from: url)
      let readings = try JSONDecoder().decode([Double].self, from: data)
      return "Found \(readings.count) readings"
    }
    
    let result = await fetchTask.result
    
    switch result {
    case .success(let value):
      output = value
    case .failure(let error):
      output = "Error: \(error.localizedDescription)"
    }
    
    // or
    /*do {
      output = try result.get()
    } catch {
      output = "Error: \(error.localizedDescription)"
    }*/
    
    // Example 1
    /* do {
       let url = URL(string: "https://hws.dev/readings.json")!
       let (data, response) = try await URLSession.shared.data(from: url)

       guard let res = response as? HTTPURLResponse,
             res.statusCode == 200 else {
         return
       }

       let readings = try JSONDecoder().decode([Double].self, from: data)
       output = "Found \(readings.count) readings"
     } catch {
       print("Download error")
     } */
  }
}

// MARK: - Day79View_Previews

struct Day79View_Previews: PreviewProvider {
  static var previews: some View {
    Day79View()
  }
}
