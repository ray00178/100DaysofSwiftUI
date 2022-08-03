//
//  ProspectsView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/2.
//

import SwiftUI

// MARK: - ProspectsView

struct ProspectsView: View {
  @EnvironmentObject var prospects: Prospects

  let filter: FilterType

  var title: String {
    switch filter {
    case .none:
      return "Everyone"
    case .contacted:
      return "Contacted people"
    case .uncontacted:
      return "Uncontacted people"
    case .me:
      return "Profile"
    }
  }

  var filteredProspects: [Prospect] {
    switch filter {
    case .none, .me:
      return prospects.people
    case .contacted:
      return prospects.people.filter(\.isContacted)
    case .uncontacted:
      return prospects.people.filter { !$0.isContacted }
    }
  }

  var body: some View {
    NavigationView {
      List {
        ForEach(filteredProspects) { prospects in
          VStack(alignment: .leading) {
            Text(prospects.name)
              .font(.headline)
            Text(prospects.emailAddress)
              .foregroundColor(.secondary)
          }
        }
      }
      .navigationTitle(title)
      .toolbar {
        Button {
          let prospect = Prospect()
          prospect.name = "Paul Hudson"
          prospect.emailAddress = "paul@hackingwithswift.com"
          prospects.people.append(prospect)
        } label: {
          Label("Scan", systemImage: "qrcode.viewfinder")
        }
      }
    }
  }
}

// MARK: - ProspectsView_Previews

struct ProspectsView_Previews: PreviewProvider {
  static var previews: some View {
    ProspectsView(filter: .none)
      .environmentObject(Prospects())
  }
}

extension ProspectsView {
  enum FilterType {
    case none

    case contacted

    case uncontacted

    case me
  }
}
