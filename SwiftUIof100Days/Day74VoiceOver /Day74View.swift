//
//  Day74View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/25.
//

import SwiftUI

// MARK: - Day74View

struct Day74View: View {
  let pictures = [
    "ales-krivec-15949",
    "galina-n-189483",
    "kevin-horstmann-141705",
    "nicolas-tissot-335096",
  ]

  let labels = [
    "Tulips",
    "Frozen tree buds",
    "Sunflowers",
    "Fireworks",
  ]

  @State private var selectedPicture = Int.random(in: 0 ... 3)

  var body: some View {
    Image(pictures[selectedPicture])
      .resizable()
      .scaledToFit()
      .onTapGesture {
        selectedPicture = Int.random(in: 0 ... 3)
      }
      .overlay(content: {
        VStack {
          Text("Your score is")
            .font(.system(.title, design: .monospaced))
            .foregroundColor(.white)
          Text("1000")
            .font(.title)
            .foregroundColor(.white)
        }
        //.accessibilityElement(children: .combine)
        // or
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Your score is 1000")
      })
      .accessibilityLabel(labels[selectedPicture])
      .accessibilityAddTraits(.isButton)
      .accessibilityRemoveTraits(.isImage)
  }
}

// MARK: - Day74View_Previews

struct Day74View_Previews: PreviewProvider {
  static var previews: some View {
    Day74View()
  }
}
