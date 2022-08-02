//
//  MeView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/2.
//

import SwiftUI

// MARK: - MeView

struct MeView: View {
  var body: some View {
    TabView {
      ProspectsView(filter: .none)
        .tabItem {
          Label("Everyone", systemImage: "person.2")
        }
      ProspectsView(filter: .contacted)
        .tabItem {
          Label("Contacted", systemImage: "checkmark.circle")
        }
      ProspectsView(filter: .uncontacted)
        .tabItem {
          Label("Uncontacted", systemImage: "questionmark.diamond")
        }
      ProspectsView(filter: .me)
        .tabItem {
          Label("Me", systemImage: "person.crop.square")
        }
    }
  }
}

// MARK: - MeView_Previews

struct MeView_Previews: PreviewProvider {
  static var previews: some View {
    MeView()
  }
}
