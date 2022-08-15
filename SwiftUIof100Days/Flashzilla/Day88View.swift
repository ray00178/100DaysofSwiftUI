//
//  Day88View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/11.
//

import SwiftUI

// MARK: - Day88View

struct Day88View: View {
  @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor

  @Environment(\.scenePhase) var scenePhase

  @State private var cards: [Card] = Array(repeating: Card.example, count: 10)
  @State private var timeRemaining = 100
  @State private var isActive = true

  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

  var body: some View {
    ZStack {
      Image("background")
        .resizable()
        .ignoresSafeArea()

      VStack(spacing: 20) {
        Text("Time: \(timeRemaining)")
          .font(.largeTitle)
          .foregroundColor(.white)
          .padding(.horizontal, 20)
          .padding(.vertical, 5)
          .background(.black.opacity(0.75))
          .clipShape(Capsule())

        ZStack {
          ForEach(0 ..< cards.count, id: \.self) { index in
            CardView(card: cards[index]) {
              withAnimation {
                removeCard(at: index)
              }
            }
            .statck(at: index, total: cards.count)
          }
        }
        .allowsHitTesting(timeRemaining > 0)

        if cards.isEmpty {
          Button("Start Agent", action: resetCards)
            .padding()
            .background(.white)
            .foregroundColor(.black)
            .clipShape(Capsule())
        }
      }

      if accessibilityDifferentiateWithoutColor {
        VStack {
          Spacer()

          HStack {
            Image(systemName: "xmark.circle")
              .padding()
              .background(.black.opacity(0.7))
              .clipShape(Circle())

            Spacer()

            Image(systemName: "checkmark.circle")
              .padding()
              .background(.black.opacity(0.7))
              .clipShape(Circle())
          }
          .foregroundColor(.white)
          .font(.largeTitle)
          .padding()
        }
      }
    }.onReceive(timer) { _ in
      guard isActive else { return }

      if timeRemaining > 0 {
        timeRemaining -= 1
      }
    }
    .onChange(of: scenePhase) { newValue in
      switch newValue {
      case .active:
        if cards.isEmpty == false {
          isActive = true
        }
      default:
        isActive = false
      }
    }
  }

  func removeCard(at index: Int) {
    cards.remove(at: index)

    if cards.isEmpty {
      isActive = false
    }
  }

  func resetCards() {
    cards = Array(repeating: Card.example, count: 10)
    timeRemaining = 100
    isActive = true
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
