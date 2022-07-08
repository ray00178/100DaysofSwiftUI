//
//  Day68View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/7.
//

import SwiftUI

// MARK: - Day68View

struct Day68View: View {
  
  @State private var loadingState = LoadingState.loading

  private let models: [Day68Model] = [
    Day68Model(name: "Ray", age: 34),
    Day68Model(name: "Aida", age: 31),
    Day68Model(name: "Jhon", age: 40),
    Day68Model(name: "Mary", age: 24),
  ].sorted()

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: 8.0) {
        ForEach(models) { model in
          Text("\(model.name) (\(model.age))")
            .padding(12.0)
            .foregroundColor(model.age > 30 ? .red : .blue)
            .onTapGesture {
              loadingState = LoadingState.allCases.randomElement() ?? .loading

              /* let str = model.name + " \(model.age)"
               let url = getDocumentDictionary().appendingPathComponent("temp.txt", conformingTo: .text)

               do {
                 try str.write(to: url, atomically: true, encoding: .utf8)
                 let input = try String(contentsOf: url)
                 print(input)
               } catch {
                 print("Error: \(error.localizedDescription)")
               } */
            }
        }
        
        Spacer()
        
        Text(loadingState.message)
          .padding(20.0)
          .font(.headline)
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

// MARK: - LoadingState

enum LoadingState: CaseIterable {
  
  case loading

  case success

  case failure
  
  var message: String {
    switch self {
    case .loading:
      return "Loading..."
    case .success:
      return "🎉 Success"
    case .failure:
      return "🌚 Failure"
    }
  }
}
