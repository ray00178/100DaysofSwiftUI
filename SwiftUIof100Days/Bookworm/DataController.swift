//
//  DataController.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/14.
//

import Foundation
import CoreData

class DataController: ObservableObject {
  
  // NS part is short for NeXTSTEP
  let container = NSPersistentContainer(name: "Bookworm")
  
  init() {
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Core Data failed to load: \(error.localizedDescription)")
        return
      }
    }
  }
}
