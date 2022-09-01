//
//  Day97View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/29.
//

import SwiftUI

// MARK: - Day97View

struct Day97View: View {
  @State private var searchText = ""
  @StateObject private var favorites = Favorites()

  let resorts: [Resort] = Bundle.main.decode("resorts.json")

  var filteredResorts: [Resort] {
    if searchText.isEmpty {
      return resorts
    } else {
      return resorts.filter { $0.name.localizedStandardContains(searchText) }
    }
  }

  var body: some View {
    NavigationView {
      List(filteredResorts) { resort in
        NavigationLink {
          ResortView(resort: resort)
        } label: {
          Image(resort.country)
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 25)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
            .overlay(RoundedRectangle(cornerRadius: 5.0).stroke(.black, lineWidth: 1))

          VStack(alignment: .leading) {
            Text(resort.name)
              .font(.headline)
            
            HStack(spacing: 8.0) {
              Text("\(resort.runs) runs")
                .foregroundColor(.secondary)
              
              if favorites.contains(resort) {
                Image(systemName: "heart.fill")
                  .accessibilityLabel("This is a favorite resort")
                  .foregroundColor(.yellow)
                  .frame(width: 16.0, height: 16.0)
              }
            }
          }
        }
      }
      .navigationTitle("Resorts")
      .searchable(text: $searchText, prompt: "Search for a resort")

      WelcomeView()
    }
    .environmentObject(favorites)
  }
}

// MARK: - Day97View_Previews

struct Day97View_Previews: PreviewProvider {
  static var previews: some View {
    Day97View()
  }
}

extension View {
  @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
    if UIDevice.current.userInterfaceIdiom == .phone {
      navigationViewStyle(.stack)
    } else {
      self
    }
  }
}
