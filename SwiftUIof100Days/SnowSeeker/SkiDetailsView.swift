//
//  SkiDetailsView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/29.
//

import SwiftUI

// MARK: - SkiDetailsView

struct SkiDetailsView: View {
  let resort: Resort

  var body: some View {
    Group {
      VStack {
        Text("Elevation")
          .font(.caption.bold())

        Text("\(resort.elevation)m")
          .font(.title3)
      }

      VStack {
        Text("Snow")
          .font(.caption.bold())
        Text("\(resort.snowDepth)cm")
          .font(.title3)
      }
    }
    .frame(maxWidth: .infinity)
  }
}

// MARK: - SkiDetailsView_Previews

struct SkiDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    SkiDetailsView(resort: Resort.example)
  }
}
