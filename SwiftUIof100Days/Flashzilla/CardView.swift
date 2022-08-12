//
//  CardView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/11.
//

import SwiftUI

// MARK: - CardView

struct CardView: View {
  @State private var isShowingAnswer = false

  @State private var offset = CGSize.zero

  let card: Card

  var removal: (() -> Void)? = nil
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25.0, style: .circular)
        .fill(.white)
        .shadow(radius: 10)

      VStack {
        Text(card.prompt)
          .font(.largeTitle)
          .foregroundColor(.black)

        if isShowingAnswer {
          Text(card.answer)
            .font(.title)
            .foregroundColor(.gray)
        }
      }
      .padding(20)
      .multilineTextAlignment(.center)
    }
    .frame(width: 380, height: 250)
    .rotationEffect(.degrees(Double(offset.width / 5)))
    .offset(x: offset.width * 5, y: 0)
    .opacity(1 - Double(abs(offset.width / 100)))
    .onTapGesture {
      withAnimation {
        isShowingAnswer.toggle()
      }
    }
    .gesture(DragGesture()
      .onChanged { gesture in
        offset = gesture.translation
      }
      .onEnded { _ in
        if abs(offset.width) > 100 {
          removal?()
        } else {
          withAnimation {
            offset = .zero
          }
        }
      })
  }
}

// MARK: - CardView_Previews

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(card: Card.example)
  }
}
