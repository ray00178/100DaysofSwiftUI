//
//  Day88View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/11.
//

import SwiftUI

// MARK: - Day88View

struct Day88View: View {
  @State private var cards: [Card] = Array(repeating: Card.example, count: 10)

  var body: some View {
    ZStack {
      Image("background")
        .resizable()
        .ignoresSafeArea()
      
      VStack {
        ZStack {
          ForEach(0 ..< cards.count, id: \.self) { index in
            CardView(card: cards[index])
              .statck(at: index, total: cards.count)
          }
        }
      }
    }
  }
}

// MARK: - Day88View_Previews

struct Day88View_Previews: PreviewProvider {
  static var previews: some View {
    Day88View()
  }
}

// MARK: - Extension

extension View {
  
  func statck(at position: Int, total: Int) -> some View {
    let offset = Double(total - position)
    return self.offset(x: 0, y: offset)
  }
}
