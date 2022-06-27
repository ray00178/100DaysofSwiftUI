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

  // "universe == 'Star Wars'"
  // "name < %@", "F"
  // "universe IN %@", ["Aliens", "Firefly", "Star Trek"]
  // "NOT name BEGINSWITH[c] %@", "e"
  @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>

  @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>

  @State private var lastNameFilter = "A"

  var body: some View {
    NavigationView {
      VStack(spacing: 8.0) {
        List(countries, id: \.self) { country in
          Section(country.wrappedFullName) {
            ForEach(country.candyArray, id: \.self) { candy in
              NavigationLink {
                Text(candy.wrappedName)
              } label: {
                Text(candy.wrappedName)
              }
            }
          }
        }

        Button("Add") {
          let candy1 = Candy(context: moc)
          candy1.shortName = "Mars"
          candy1.origin = Country(context: moc)
          candy1.origin?.shortName = "UK"
          candy1.origin?.fullName = "United Kingdom"

          let candy2 = Candy(context: moc)
          candy2.shortName = "KitKat"
          candy2.origin = Country(context: moc)
          candy2.origin?.shortName = "UK"
          candy2.origin?.fullName = "United Kingdom"

          let candy3 = Candy(context: moc)
          candy3.shortName = "Twix"
          candy3.origin = Country(context: moc)
          candy3.origin?.shortName = "UK"
          candy3.origin?.fullName = "United Kingdom"

          let candy4 = Candy(context: moc)
          candy4.shortName = "Toblerone"
          candy4.origin = Country(context: moc)
          candy4.origin?.shortName = "CH"
          candy4.origin?.fullName = "Switzerland"

          try? moc.save()
        }
      }
      .navigationBarTitle("Core Data")
    }
    /* FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
         Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
     }

     Button("Show A") {
       lastNameFilter = "A"
     }

     Button("Show S") {
       lastNameFilter = "S"
     } */

    // For Ships
    /* List(ships, id: \.self) { ship in
       Text(ship.name ?? "Unknown Name")
     }

     Button("Add Example") {
       let ship1 = Ship(context: moc)
       ship1.name = "Enterprise"
       ship1.universe = "Star Trek"

       let ship2 = Ship(context: moc)
       ship2.name = "Defiant"
       ship2.universe = "Star Trek"

       let ship3 = Ship(context: moc)
       ship3.name = "Millennium Falcon"
       ship3.universe = "Star Wars"

       let ship4 = Ship(context: moc)
       ship4.name = "Executor"
       ship4.universe = "Star Wars"

       try? moc.save()
     }*/

    // For wizards
    /* List(wizards, id: \.self) { wizard in
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
     .padding(8) */
  }
}

// MARK: - CoreDataProjectContentView_Previews

struct CoreDataProjectContentView_Previews: PreviewProvider {
  static var previews: some View {
    CoreDataProjectContentView()
  }
}
