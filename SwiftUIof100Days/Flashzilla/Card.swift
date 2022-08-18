//
//  Card.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/11.
//

import Foundation

struct Card: Codable {
  let prompt: String
  let answer: String
  
  static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
