//
//  SwiftUIof100DaysApp.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/4/17.
//

import SwiftUI

@main
struct SwiftUIof100DaysApp: App {
  
  /// For Bookworm project
  @StateObject private var dataController = DataController()
  
  var body: some Scene {
    WindowGroup {
      BookwormContentView()
        .environment(\.managedObjectContext, dataController.container.viewContext)
    }
  }
}
