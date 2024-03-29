//
//  Day21View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/4/21.
//

import SwiftUI

// MARK: - Day21View

struct Day21View: View {
  @State private var showingScore = false
  @State private var scoreTitle = ""

  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0 ... 2)

  let labels = [
    "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
    "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
    "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
    "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
    "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
    "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
    "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
    "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
    "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
    "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
    "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner",
  ]

  var body: some View {
    ZStack {
      RadialGradient(stops: [
        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
      ], center: .top, startRadius: 200, endRadius: 400)
        .ignoresSafeArea()
      /* LinearGradient(colors: [.blue, .black],
                  startPoint: .top,
                  endPoint: .bottom)
       .ignoresSafeArea() */

      VStack {
        Spacer()

        Text("Guess the Flag")
          .font(.largeTitle.bold())
          .foregroundColor(.white)

        VStack(spacing: 15.0) {
          VStack {
            Text("Tap the flag of")
              .foregroundStyle(.secondary)
              .font(.subheadline.weight(.heavy))
            Text(countries[correctAnswer])
              .font(.largeTitle.weight(.heavy))
          }

          ForEach(0 ..< 3) { number in
            Button {
              flagTapped(number)
            } label: {
              Image(countries[number])
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
                .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))

        Spacer()
        Spacer()

        Text("Score: ???")
          .foregroundColor(.white)
          .font(.title.bold())
        Spacer()
      }
      .padding()
    }
    .alert(scoreTitle, isPresented: $showingScore) {
      Button("Continue", action: askQuestion)
    } message: {
      Text("Your score is?")
    }
  }

  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0 ... 2)
  }

  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
    } else {
      scoreTitle = "Wrong"
    }

    showingScore = true
  }
}

// MARK: - Day21View_Previews

struct Day21View_Previews: PreviewProvider {
  static var previews: some View {
    Day21View()
  }
}
