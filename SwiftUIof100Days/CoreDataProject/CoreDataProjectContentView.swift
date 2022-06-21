//
//  CoreDataProjectContentView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/21.
//

import SwiftUI

// MARK: - CoreDataProjectContentView

struct CoreDataProjectContentView: View {
  @Environment(\.managedObjectContext) var moc

  @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>

  var body: some View {
    VStack(spacing: 8.0) {
      List(wizards, id: \.self) { wizard in
        Text(wizard.name ?? "Unknown Title")
      }

      Button("Add") {
        let wizard = Wizard(context: moc)
        wizard.name = "Harry Potter"
        
      }
      .padding(8)
      
      Button("Save") {
        do {
          try moc.save()
        } catch {
          print(error.localizedDescription)
        }
      }
      .padding(8)
    }
  }
}

// MARK: - CoreDataProjectContentView_Previews

struct CoreDataProjectContentView_Previews: PreviewProvider {
  static var previews: some View {
    CoreDataProjectContentView()
  }
}
