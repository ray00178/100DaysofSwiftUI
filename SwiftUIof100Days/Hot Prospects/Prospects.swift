//
//  Prospects.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/3.
//

import SwiftUI

@MainActor
class Prospects: ObservableObject {
  
  @Published var people: [Prospect]
  
  init() {
    self.people = []
  }
  
  func toggle(_ prospect: Prospect) {
    objectWillChange.send()
    prospect.isContacted.toggle()
  }
}
