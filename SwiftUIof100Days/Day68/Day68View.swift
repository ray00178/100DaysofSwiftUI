//
//  Day68View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/7.
//

import SwiftUI

// MARK: - Day68View

struct Day68View: View {
  private let models: [Day68Model] = [
    Day68Model(name: "Ray", age: 34),
    Day68Model(name: "Aida", age: 31),
    Day68Model(name: "Jhon", age: 40),
    Day68Model(name: "Mary", age: 24),
  ].sorted()

  var body: some View {
    List(models) { model in
      Text("\(model.name) (\(model.age))")
        .foregroundColor(model.age > 30 ? .red : .blue)
        .onTapGesture {
          let str = model.name + " \(model.age)"
          let url = getDocumentDictionary().appendingPathComponent("temp.txt", conformingTo: .text)

          do {
            try str.write(to: url, atomically: true, encoding: .utf8)
            let input = try String(contentsOf: url)
            print(input)
          } catch {
            print("Error: \(error.localizedDescription)")
          }
        }
    }
  }

  func getDocumentDictionary() -> URL {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    return path[0]
  }
}

// MARK: - Day68View_Previews

struct Day68View_Previews: PreviewProvider {
  static var previews: some View {
    Day68View()
  }
}

// MARK: - Day68Model

struct Day68Model: Identifiable, Comparable {
  let id: UUID = .init()
  var name: String
  var age: Int

  static func < (lhs: Day68Model, rhs: Day68Model) -> Bool {
    lhs.age > rhs.age
  }
}
