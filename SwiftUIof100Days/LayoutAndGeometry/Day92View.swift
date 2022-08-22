//
//  Day92View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/21.
//

import SwiftUI

// MARK: - Day92View

struct Day92View: View {
  var body: some View {
    
    VStack(spacing: 20) {
      HStack(alignment: .midAccountAndName) {
        VStack {
          Text("@twostraws")
            .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
          Image("lovell")
            .resizable()
            .frame(width: 64, height: 64)
            .clipShape(Capsule())
        }

        VStack {
          Text("Full name:")
          Text("Ray Jhang")
            .font(.largeTitle)
            .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
        }
      }

      Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        .frame(width: 140, height: 50, alignment: .topTrailing)
        // .offset(x: -90, y: 100)
        .background(Color.red)

      HStack(alignment: .lastTextBaseline) {
        Text("One")
          .font(.largeTitle)
        Text("Two")
        Text("Three")
          .font(.subheadline)
        Text("four")
          .font(.callout)
      }

      VStack(alignment: .leading) {
        Text("Hello world")
          // 改變對齊位置
          .alignmentGuide(.leading) { dimensions in
            dimensions[.trailing]
          }
        Text("This is a longer line of text")
      }
      .background(Color.yellow)

      VStack(alignment: .leading) {
        ForEach(0 ..< 10) { position in
          Text("Number \(position)")
            .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
        }
      }
      .background(.red)
      .frame(width: 200, height: 240)
      .background(.blue)
    }
  }
}

// MARK: - Day91View_Previews

struct Day91View_Previews: PreviewProvider {
  static var previews: some View {
    Day92View()
  }
}

extension VerticalAlignment {
  struct MidAccountAndName: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
      context[.top]
    }
  }

  static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}
