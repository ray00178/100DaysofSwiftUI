//
//  Country+CoreDataProperties.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/27.
//
//

import CoreData
import Foundation

public extension Country {
  @nonobjc class func fetchRequest() -> NSFetchRequest<Country> {
    NSFetchRequest<Country>(entityName: "Country")
  }

  @NSManaged var fullName: String?
  @NSManaged var shortName: String?
  @NSManaged var candy: NSSet?
 
  var wrappedShortName: String {
      shortName ?? "Unknown Country"
  }

  var wrappedFullName: String {
      fullName ?? "Unknown Country"
  }
  
  var candyArray: [Candy] {
    let set = candy as? Set<Candy> ?? []
    return set.sorted {
      $0.wrappedName < $1.wrappedName
    }
  }
}

// MARK: Generated accessors for candy

public extension Country {
  @objc(addCandyObject:)
  @NSManaged func addToCandy(_ value: Candy)

  @objc(removeCandyObject:)
  @NSManaged func removeFromCandy(_ value: Candy)

  @objc(addCandy:)
  @NSManaged func addToCandy(_ values: NSSet)

  @objc(removeCandy:)
  @NSManaged func removeFromCandy(_ values: NSSet)
}

// MARK: - Country + Identifiable

extension Country: Identifiable {}
