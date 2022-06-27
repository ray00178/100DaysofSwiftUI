//
//  Singer+CoreDataProperties.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/27.
//
//

import CoreData
import Foundation

public extension Singer {
  @nonobjc class func fetchRequest() -> NSFetchRequest<Singer> {
    NSFetchRequest<Singer>(entityName: "Singer")
  }

  @NSManaged var firstName: String?
  @NSManaged var lastName: String?

  var wrappedFirstName: String {
    firstName ?? "Unknown"
  }

  var wrappedLastName: String {
    lastName ?? "Unknown"
  }
}

// MARK: - Singer + Identifiable

extension Singer: Identifiable {}
