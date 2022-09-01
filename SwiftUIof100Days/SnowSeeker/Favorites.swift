//
//  Favorites.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/31.
//

import SwiftUI

class Favorites: ObservableObject {
  
  private var resorts: Set<String>
  
  private let saveKey = "Favorites"
  
  init() {
    if let value = UserDefaults.standard.object(forKey: saveKey) as? String {
      resorts = Set(value.components(separatedBy: ","))
      return
    }
    
    resorts = []
  }
  
  func contains(_ resort: Resort) -> Bool {
    resorts.contains(resort.id)
  }
  
  func add(_ resort: Resort) {
    objectWillChange.send()
    resorts.insert(resort.id)
    save()
  }
  
  func remove(_ resort: Resort) {
    objectWillChange.send()
    resorts.remove(resort.id)
    save()
  }
  
  func save() {
    UserDefaults.standard.set(resorts.joined(separator: ","), forKey: saveKey)
  }
}
