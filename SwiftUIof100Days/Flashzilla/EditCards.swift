//
//  EditCards.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/18.
//

import SwiftUI

// MARK: - EditCards

struct EditCards: View {
  @Environment(\.dismiss) var dismiss

  @State private var cards = [Card]()
  @State private var newPrompt = ""
  @State private var newAnswer = ""

  var body: some View {
    NavigationView {
      List {
        Section("Add New Card") {
          TextField("Prompt", text: $newPrompt)
          TextField("Answer", text: $newAnswer)
          Button("Add Card", action: addCard)
        }

        Section {
          ForEach(0 ..< cards.count, id: \.self) { index in
            VStack(alignment: .leading) {
              Text(cards[index].prompt)
                .font(.headline)
              Text(cards[index].answer)
                .foregroundColor(.secondary)
            }
          }
          .onDelete(perform: removeCards)
        }
      }
      .navigationTitle("Edit Cards")
      .toolbar {
        Button("Done", action: done)
      }
      .listStyle(.grouped)
      .onAppear(perform: loadData)
    }
  }

  func loadData() {
    guard let data = UserDefaults.standard.data(forKey: "Cards"),
          let value = try? JSONDecoder().decode([Card].self, from: data)
    else {
      return
    }

    cards = value
  }

  func saveData() {
    guard let data = try? JSONEncoder().encode(cards)
    else {
      return
    }

    UserDefaults.standard.setValue(data, forKey: "Cards")
  }

  func addCard() {
    let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
    let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)

    guard trimmedPrompt.isEmpty == false,
          trimmedAnswer.isEmpty == false
    else {
      return
    }

    let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
    cards.insert(card, at: 0)
    saveData()
  }

  func removeCards(at offsets: IndexSet) {
    cards.remove(atOffsets: offsets)
    saveData()
  }

  func done() {
    dismiss()
  }
}

// MARK: - EditCards_Previews

struct EditCards_Previews: PreviewProvider {
  static var previews: some View {
    EditCards()
  }
}
