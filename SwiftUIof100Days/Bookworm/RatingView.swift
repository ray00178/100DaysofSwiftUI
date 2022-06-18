//
//  RatingView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/18.
//

import SwiftUI

// MARK: - RatingView

struct RatingView: View {
  @Binding var rating: Int

  var label = ""

  var maxRating = 5

  var offImage: Image?
  var onImage = Image(systemName: "star.fill")

  var offColor = Color.gray
  var onColor = Color.yellow

  var body: some View {
    HStack {
      if label.isEmpty == false {
        Text(label)
      }
      
      ForEach(1 ... maxRating, id: \.self) { number in
        image(number: number)
          .foregroundColor(number > rating ? offColor : onColor)
          .onTapGesture {
            rating = number
          }
      }
    }
  }
  
  func image(number: Int) -> Image {
    if number > maxRating {
      return offImage ?? onImage
    } else {
      return onImage
    }
  }
}

// MARK: - RatingView_Previews

struct RatingView_Previews: PreviewProvider {
  static var previews: some View {
    RatingView(rating: .constant(4))
  }
}
