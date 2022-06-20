//
//  DetailView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/20.
//

import CoreData
import SwiftUI

// MARK: - DetailView

struct DetailView: View {
  @Environment(\.managedObjectContext) var moc
  @Environment(\.dismiss) var dissmiss
  @State private var showingDeleteAlert = false

  let book: Book?

  var body: some View {
    ScrollView {
      ZStack(alignment: .bottomTrailing) {
        Image(book?.genre ?? "Fantasy")
          .resizable()
          .scaledToFit()

        Text(book?.genre?.uppercased() ?? "FANTASY")
          .font(.caption)
          .fontWeight(.black)
          .padding(8)
          .foregroundColor(.white)
          .background(.black.opacity(0.75))
          .clipShape(Capsule())
          .offset(x: -8, y: -8)
      }

      Text(book?.author ?? "Unknown author")
        .font(.title)
        .foregroundColor(.secondary)

      Text(book?.review ?? "No review")
        .padding()

      RatingView(rating: .constant(Int(book?.rating ?? 0)))
        .font(.largeTitle)
    }
    .navigationTitle(book?.title ?? "Unknown Book")
    .navigationBarTitleDisplayMode(.inline)
    .alert("Delete Book", isPresented: $showingDeleteAlert) {
      Button("Delete", role: .destructive, action: deleteBook)
      Button("Cancel", role: .cancel) {}
    } message: {
      Text("Are you sure?")
    }
    .toolbar {
      Button {
        showingDeleteAlert = true
      } label: {
        Label("Delete this book", systemImage: "trash")
      }
    }
  }

  func deleteBook() {
    guard let book = book else { return }

    moc.delete(book)

    // uncomment this line if you want to make the deletion permanent
    // try? moc.save()
    dissmiss()
  }
}

// MARK: - DetailView_Previews

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(book: nil)
  }
}
