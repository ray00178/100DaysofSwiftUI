//
//  CoreDataProjectDataController.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/21.
//

import Foundation
import CoreData

class CoreDataProjectDataController: ObservableObject {
  
  // NS part is short for NeXTSTEP
  let container = NSPersistentContainer(name: "CoreDataProject")
  
  init() {
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Core Data failed to load: \(error.localizedDescription)")
        return
      }
      
      // Reference = https://www.hackingwithswift.com/books/ios-swiftui/ensuring-core-data-objects-are-unique-using-constraints
      self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
  }
}
