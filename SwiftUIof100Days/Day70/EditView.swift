//
//  EditView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/17.
//

import SwiftUI

// MARK: - EditView

struct EditView: View {
  @Environment(\.dismiss) var dismiss
  var location: Day70View.Location

  @State private var name: String
  @State private var description: String
  @State private var loadingState = EditView.LoadingState.loading
  @State private var pages = [Page]()

  var onSave: (Day70View.Location) -> Swift.Void

  init(location: Day70View.Location, onSave: @escaping (Day70View.Location) -> Swift.Void) {
    self.location = location
    self.onSave = onSave

    _name = State(initialValue: location.name)
    _description = State(initialValue: location.description)
  }

  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Place name", text: $name)
          TextField("Description", text: $description)
        }

        Section("NearBy...") {
          switch loadingState {
          case .loaded:
            ForEach(pages, id: \.pageid) { page in
              Text(page.title)
                .font(.headline)
                + Text(": ") +
              Text(page.description)
                .italic()
            }
          case .loading:
            Text("Loading…")
          case .failed:
            Text("Please try again later.")
          }
        }
      }
      .navigationTitle("Place details")
      .toolbar {
        Button("Save") {
          var newLocation = location
          newLocation.id = UUID()
          newLocation.name = name
          newLocation.description = description

          onSave(newLocation)
          dismiss()
        }
      }
      .task {
        await fetchNearByPlaces()
      }
    }
  }

  func fetchNearByPlaces() async {
    let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

    guard let url = URL(string: urlString) else {
      print("Bad URL: \(urlString)")
      return
    }

    do {
      let (data, _) = try await URLSession.shared.data(from: url)

      let items = try JSONDecoder().decode(ResultData.self, from: data)
      pages = items.query.pages.values.sorted()
      
      loadingState = .loaded
    } catch {
      loadingState = .failed
    }
  }
}

// MARK: - EditView_Previews

struct EditView_Previews: PreviewProvider {
  static var previews: some View {
    EditView(location: Day70View.Location.example, onSave: { _ in })
  }
}

// MARK: - LoadingState

extension EditView {
  enum LoadingState {
    case loading, loaded, failed
  }
}
