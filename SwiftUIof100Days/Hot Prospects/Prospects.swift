//
//  Prospects.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/3.
//

import SwiftUI
import UserNotifications

@MainActor
class Prospects: ObservableObject {
  @Published private(set) var people: [Prospect]

  let saveKey = "ProspectData"

  init() {
    if let data = UserDefaults.standard.data(forKey: saveKey),
       let result = try? JSONDecoder().decode([Prospect].self, from: data)
    {
      people = result

      return
    }

    people = []
  }

  func toggle(_ prospect: Prospect) {
    objectWillChange.send()
    prospect.isContacted.toggle()
    save()
  }

  func add(_ prospect: Prospect) {
    people.append(prospect)
    save()
  }

  private func save() {
    if let result = try? JSONEncoder().encode(people) {
      UserDefaults.standard.set(result, forKey: saveKey)
    }
  }
}
