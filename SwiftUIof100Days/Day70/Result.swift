//
//  Result.swift
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

struct Page: Codable {
  let pageid: Int
  let title: String
  let terms: [String: [String]]?
}
