//
//  FileManager-DocumentsDirectory.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/19.
//

import Foundation

extension FileManager {
  
  static var documentsDictionary: URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
}
