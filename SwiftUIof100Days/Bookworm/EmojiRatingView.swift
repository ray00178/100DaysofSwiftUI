//
//  EmojiRatingView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/18.
//

import SwiftUI

// MARK: - EmojiRatingView

struct EmojiRatingView: View {
  let rating: Int16

  var body: some View {
    switch rating {
    case 0 ..< 4:
      Text("\(rating)")
    default:
      Text("5")
    }
  }
}

// MARK: - EmojiRatingView_Previews

struct EmojiRatingView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiRatingView(rating: 3)
  }
}
