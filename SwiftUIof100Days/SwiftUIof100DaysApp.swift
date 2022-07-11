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
  
  /// For CoreDataProject project
  @StateObject private var dataController2 = CoreDataProjectDataController()
  
  var body: some Scene {
    WindowGroup {
      /*BookwormContentView()
        .environment(\.managedObjectContext, dataController.container.viewContext)*/
      
      /*CoreDataProjectContentView()
        .environment(\.managedObjectContext, dataController2.container.viewContext)*/
      
      Day69View()
    }
  }
}
