//
//  Day93View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/22.
//

import SwiftUI

// MARK: - Day93View

// Reference: https://www.hackingwithswift.com/books/ios-swiftui/understanding-frames-and-coordinates-inside-geometryreader
struct Day93View: View {
  let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 0) {
        ForEach(1 ..< 20) { num in
          GeometryReader { geo in
            Text("Number \(num)")
              .font(.largeTitle)
              .padding()
              .background(.red)
              .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
              .frame(width: 200, height: 200)
          }
          .frame(width: 200, height: 200)
        }
      }
    }

    /* GeometryReader { fullView in
       ScrollView {
         ForEach(0 ..< 50) { index in
           GeometryReader { geo in
             Text("Row #\(index)")
               .font(.title)
               .frame(maxWidth: .infinity)
               .background(colors[index % 7])
               .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
           }
           .frame(height: 40)
         }
       }
     } */

    /* OuterView()
     .background(.red)
     .coordinateSpace(name: "Custom") */

    /* VStack(spacing: 0) {
       GeometryReader { geo in
         Text("Hello World!")
           .frame(width: geo.size.width * 0.9)
           .background(Color.yellow)
       }
       .background(Color.red)

       Text("Hi Friend~")
         .background(Color.green)
     } */

    /* Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
     //.position(x: 100, y: 100)
     .background(Color.blue)
     .offset(x: 100, y: 100) */
  }
}

// MARK: - OuterView

struct OuterView: View {
  var body: some View {
    VStack {
      Text("Top")

      InnerView()
        .background(.green)

      Text("Bottom")
    }
  }
}

// MARK: - InnerView

struct InnerView: View {
  var body: some View {
    HStack {
      Text("Left")

      GeometryReader { geo in
        Text("Center")
          .background(.blue)
          .onTapGesture {
            print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
            print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
            print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
          }
      }
      .background(.orange)

      Text("Right")
    }
  }
}

// MARK: - Day93View_Previews

struct Day93View_Previews: PreviewProvider {
  static var previews: some View {
    Day93View()
  }
}
