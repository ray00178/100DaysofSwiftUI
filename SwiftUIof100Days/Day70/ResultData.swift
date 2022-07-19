//
//  ResultData.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/18.
//

// MARK: - ResultData

struct ResultData: Codable {
  let query: Query
}

// MARK: - Query

struct Query: Codable {
  let pages: [Int: Page]
}

// MARK: - Page

struct Page: Codable, Comparable {
  let pageid: Int
  let title: String
  let terms: [String: [String]]?
  
  var description: String {
    terms?["description"]?.first ?? "No further information"
  }
  
  static func < (lhs: Page, rhs: Page) -> Bool {
    lhs.title < rhs.title
  }
}
