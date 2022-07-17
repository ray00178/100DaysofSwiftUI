//
//  EditView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/17.
//

import SwiftUI

// MARK: - EditView

struct EditView: View {
  @Environment(\.dismiss) var dismiss
  var location: Day70View.Location

  @State private var name: String
  @State private var description: String

  var onSave: (Day70View.Location) -> Swift.Void

  init(location: Day70View.Location, onSave: @escaping (Day70View.Location) -> Swift.Void) {
    self.location = location
    self.onSave = onSave

    _name = State(initialValue: location.name)
    _description = State(initialValue: location.description)
  }

  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Place name", text: $name)
          TextField("Description", text: $description)
        }
      }
      .navigationTitle("Place details")
      .toolbar {
        Button("Save") {
          var newLocation = location
          newLocation.id = UUID()
          newLocation.name = name
          newLocation.description = description

          onSave(newLocation)
          dismiss()
        }
      }
    }
  }
}

// MARK: - EditView_Previews

struct EditView_Previews: PreviewProvider {
  static var previews: some View {
    EditView(location: Day70View.Location.example, onSave: { _ in })
  }
}
