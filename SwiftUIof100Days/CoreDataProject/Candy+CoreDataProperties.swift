//
//  Candy+CoreDataProperties.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/27.
//
//

import CoreData
import Foundation

public extension Candy {
  @nonobjc class func fetchRequest() -> NSFetchRequest<Candy> {
    NSFetchRequest<Candy>(entityName: "Candy")
  }

  @NSManaged var shortName: String?
  @NSManaged var origin: Country?

  var wrappedName: String {
    shortName ?? "Unknown Candy"
  }
}

// MARK: - Candy + Identifiable

extension Candy: Identifiable {}
