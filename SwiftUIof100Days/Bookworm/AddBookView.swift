//
//  AddBookView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/16.
//

import SwiftUI

// MARK: - AddBookView

struct AddBookView: View {
  
  @Environment(\.managedObjectContext) var moc

  @State private var title = ""
  @State private var author = ""
  @State private var rating = 3
  @State private var genre = ""
  @State private var review = ""
  
  @Environment(\.dismiss) var dismiss
  
  let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
  
  var body: some View {
    NavigationView {
      
      Form {
        Section {
          TextField("Name of book", text: $title)
          TextField("Author's name", text: $author)
          
          Picker("Gender", selection: $genre) {
            ForEach(genres, id: \.self) {
              Text($0)
            }
          }
        }
        
        Section {
          TextEditor(text: $review)
          RatingView(rating: $rating)
        } header: {
          Text("Write a review")
        }
        
        Section {
          Button("Save") {
            let newBook = Book(context: moc)
            
            newBook.id = UUID()
            newBook.title = title
            newBook.author = author
            newBook.rating = Int16(rating)
            newBook.genre = genre
            newBook.review = review
            
            try? moc.save()
            
            dismiss()
          }
        }
      }
      .navigationTitle("Add Bool")
      
    }
  }
}

// MARK: - AddBookView_Previews

struct AddBookView_Previews: PreviewProvider {
  static var previews: some View {
    AddBookView()
  }
}
