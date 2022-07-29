//
//  DelayedUpdater.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/29.
//

import Foundation

@MainActor
class DelayerUpdater: ObservableObject {
  //@Published var value = 0
  
  var value = 0 {
    willSet {
      // 手動控制要發送的時機點
      objectWillChange.send()
    }
  }
  
  init() {
    for i in 0 ..< 10 {
      DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
        self.value += 1
      }
    }
    
  }
}
