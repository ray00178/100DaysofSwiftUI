//
//  Resort.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/29.
//

import Foundation

struct Resort: Codable, Identifiable {
  let id: String
  let name: String
  let country: String
  let description: String
  let imageCredit: String
  let price: Int
  let size: Int
  let snowDepth: Int
  let elevation: Int
  let runs: Int
  let facilities: [String]
  
  var facilityTypes: [Facility] {
    facilities.map { Facility(name: $0) }
  }
  
  // When we use static let for properties, Swift automatically makes them lazy
  // they don’t get created until they are used. 
  static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
  static let example = allResorts[0]
}
