//
//  Prospect.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/3.
//

import SwiftUI

class Prospect: Identifiable, Codable {
  var id = UUID()
  var name = "Anonymous"
  var emailAddress = ""
  var isContacted = false
}
