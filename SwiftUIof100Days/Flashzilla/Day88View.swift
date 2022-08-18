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
  @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
  @Environment(\.scenePhase) var scenePhase

  @State private var cards: [Card] = [Card]()
  @State private var timeRemaining = 100
  @State private var isActive = true
  @State private var showingEditScreen = false

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
            .statcked(at: index, total: cards.count)
            .allowsHitTesting(index == cards.count - 1)
            .accessibilityHidden(index < cards.count - 1)
          }
        }
        .allowsHitTesting(timeRemaining > 0)

        if cards.isEmpty {
          Button("Start Again", action: resetCards)
            .padding()
            .background(.white)
            .foregroundColor(.black)
            .clipShape(Capsule())
        }
      }

      VStack {
        HStack {
          Spacer()

          Button {
            showingEditScreen = true
          } label: {
            Image(systemName: "plus.circle")
              .padding()
              .background(.black.opacity(0.7))
              .clipShape(Circle())
          }
        }
        
        Spacer()
      }
      .foregroundColor(.white)
      .font(.largeTitle)
      .padding()

      if accessibilityDifferentiateWithoutColor ||
        voiceOverEnabled
      {
        VStack {
          Spacer()

          HStack {
            Button {
              withAnimation {
                removeCard(at: cards.count - 1)
              }
            } label: {
              Image(systemName: "xmark.circle")
                .padding()
                .background(.black.opacity(0.7))
                .clipShape(Circle())
            }
            .accessibilityLabel("Wrong")
            .accessibilityHint("Mark your answer as being incorrect.")

            Spacer()

            Button {
              withAnimation {
                removeCard(at: cards.count - 1)
              }
            } label: {
              Image(systemName: "checkmark.circle")
                .padding()
                .background(.black.opacity(0.7))
                .clipShape(Circle())
            }
            .accessibilityLabel("Correct")
            .accessibilityHint("Mark your answer as being correct.")
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
    .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
      EditCards()
    }
    .onAppear(perform: resetCards)
  }

  func removeCard(at index: Int) {
    guard index >= 0 else { return }

    cards.remove(at: index)

    if cards.isEmpty {
      isActive = false
    }
  }

  func resetCards() {
    timeRemaining = 100
    isActive = true
    loadData()
  }
  
  func loadData() {
    guard let data = UserDefaults.standard.data(forKey: "Cards"),
          let value = try? JSONDecoder().decode([Card].self, from: data)
    else {
      return
    }

    cards = value
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
  func statcked(at position: Int, total: Int) -> some View {
    let offset = Double(total - position)
    return self.offset(x: 0, y: offset)
  }
}
