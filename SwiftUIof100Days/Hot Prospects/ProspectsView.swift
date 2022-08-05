//
//  ProspectsView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/2.
//

import CodeScanner
import SwiftUI

// MARK: - ProspectsView

struct ProspectsView: View {
  @EnvironmentObject var prospects: Prospects

  @State private var isShowingScanner = false

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
        ForEach(filteredProspects) { prospect in
          VStack(alignment: .leading) {
            Text(prospect.name)
              .font(.headline)
            Text(prospect.emailAddress)
              .foregroundColor(.secondary)
          }
          .swipeActions {
            if prospect.isContacted {
              Button {
                prospects.toggle(prospect)
              } label: {
                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
              }
              .tint(.blue)
            } else {
              Button {
                prospects.toggle(prospect)
              } label: {
                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
              }
              .tint(.green)
            }

            // Remove
            /* Button(role: .destructive) {
               prospects.people.removeAll { $0.id == prospect.id }
             } label: {
               Label("Delete", systemImage: "music.circle")
             } */
          }
        }
      }
      .navigationTitle(title)
      .toolbar {
        Button {
          isShowingScanner = true
        } label: {
          Label("Scan", systemImage: "qrcode.viewfinder")
        }
      }
      .sheet(isPresented: $isShowingScanner) {
        CodeScannerView(codeTypes: [.qr],
                        simulatedData: "Paul Hudson\npaul@hackingwithswift.com",
                        completion: handleScan)
      }
    }
  }

  func handleScan(result: Swift.Result<ScanResult, ScanError>) {
    isShowingScanner = false

    switch result {
    case let .success(scanResult):
      let details = scanResult.string.components(separatedBy: "\n")
      guard details.count == 2 else { return }

      let person = Prospect()
      person.name = details[0]
      person.emailAddress = details[1]

      prospects.people.append(person)
    case let .failure(error):
      print("Scanning failed: \(error.localizedDescription)")
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
