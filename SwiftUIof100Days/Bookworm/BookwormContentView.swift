//
//  BookwormContentView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/14.
//

import SwiftUI

// MARK: - BookwormContentView

struct BookwormContentView: View {
  @State private var rememberMe: Bool = false

  @AppStorage("note") private var note = ""

  @Environment(\.managedObjectContext) var moc
  @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>

  @FetchRequest(sortDescriptors: [
    SortDescriptor(\.author),
    SortDescriptor(\.title, order: .reverse),
  ]) var books: FetchedResults<Book>
  @State private var showingAddScreen = false

  var body: some View {
    NavigationView {
      List {
        ForEach(books) { book in
          NavigationLink {
            DetailView(book: book)
          } label: {
            HStack {
              EmojiRatingView(rating: book.rating)
                .font(.largeTitle)

              VStack(alignment: .leading) {
                Text(book.title ?? "Unknown Title")
                  .font(.headline)
                Text(book.author ?? "Unknows Author")
                  .foregroundColor(.secondary)
              }
            }
          }
        }
        .onDelete { indexSet in
          deleteBooks(at: indexSet)
        }
      }
      .navigationTitle("Bookworm")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            showingAddScreen.toggle()
          } label: {
            Label("Add Book", systemImage: "plus")
          }
        }
        
        ToolbarItem(placement: .navigationBarLeading) {
          EditButton()
        }
      }
      .sheet(isPresented: $showingAddScreen) {
        AddBookView()
      }
    }

    /* VStack {
       List(students) { (student) in
         Text(student.name ?? "Unknown")
       }

       Button("Add") {
         let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
         let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

         let chosenFirstName = firstNames.randomElement()!
         let chosenLastName = lastNames.randomElement()!

         let student = Student(context: moc)
         student.id = UUID()
         student.name = "\(chosenFirstName) \(chosenLastName)"

         try? moc.save()
       }
     } */

    //
    /* NavigationView {
       TextEditor(text: $note)
         .navigationTitle("Notes")
         .padding()
     } */

    // Creating a custom component with @Binding
    /* VStack {
       PushButton(title: "Remember Me", isOn: $rememberMe)
       Text(rememberMe ? "On" : "Off")
     } */
  }

  func deleteBooks(at offsets: IndexSet) {
    for offset in offsets {
      // find this book in our fetch request
      let book = books[offset]

      // delete it from the context
      moc.delete(book)
    }
    
    try? moc.save()
  }
}

// MARK: - BookwormContentView_Previews

struct BookwormContentView_Previews: PreviewProvider {
  static var previews: some View {
    BookwormContentView()
  }
}

// MARK: - PushButton

struct PushButton: View {
  let title: String

  @Binding var isOn: Bool

  var onColors = [Color.red, Color.yellow]
  var offColors = [Color(white: 0.6), Color(white: 0.4)]

  var body: some View {
    Button(title) {
      isOn.toggle()
    }
    .padding()
    .background(.linearGradient(Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
    .foregroundColor(.white)
    .clipShape(Capsule())
    .shadow(radius: isOn ? 0 : 5)
  }
}
