//
//  CardView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/11.
//

import SwiftUI

// MARK: - CardView

struct CardView: View {
  @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
  @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled

  @State private var isShowingAnswer = false
  @State private var offset = CGSize.zero
  @State private var feedback = UINotificationFeedbackGenerator()

  let card: Card

  var removal: (() -> Void)?

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25.0, style: .circular)
        .fill(
          accessibilityDifferentiateWithoutColor ?
            .white :
            .white.opacity(1 - Double(abs(offset.width / 50))))
        .background(
          accessibilityDifferentiateWithoutColor ?
            nil :
            RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(offset.width > 0 ? .green : .red)
        )
        .shadow(radius: 10)

      VStack {
        if voiceOverEnabled {
          Text(isShowingAnswer ? card.answer : card.prompt)
            .font(.largeTitle)
            .foregroundColor(.black)
        } else {
          Text(card.prompt)
            .font(.largeTitle)
            .foregroundColor(.black)

          if isShowingAnswer {
            Text(card.answer)
              .font(.title)
              .foregroundColor(.gray)
          }
        }
      }
      .padding(20)
      .multilineTextAlignment(.center)
    }
    .frame(width: 380, height: 250)
    .rotationEffect(.degrees(Double(offset.width / 5)))
    .offset(x: offset.width * 5, y: 0)
    .opacity(1 - Double(abs(offset.width / 100)))
    .accessibilityAddTraits(.isButton)
    .onTapGesture {
      withAnimation {
        isShowingAnswer.toggle()
      }
    }
    .gesture(DragGesture()
      .onChanged { gesture in
        offset = gesture.translation
        feedback.prepare()
      }
      .onEnded { _ in
        if abs(offset.width) > 100 {
          if offset.width > 0 {
            feedback.notificationOccurred(.success)
          } else {
            feedback.notificationOccurred(.error)
          }

          removal?()
        } else {
          withAnimation {
            offset = .zero
          }
        }
      })
    .animation(.spring(), value: offset)
  }
}

// MARK: - CardView_Previews

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(card: Card.example)
  }
}
