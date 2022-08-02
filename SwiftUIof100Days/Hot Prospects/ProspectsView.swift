//
//  ProspectsView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/2.
//

import SwiftUI

// MARK: - ProspectsView

struct ProspectsView: View {
  
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

  var body: some View {
    NavigationView {
      Text("Hello world")
        .navigationTitle(title)
    }
  }
}

// MARK: - ProspectsView_Previews

struct ProspectsView_Previews: PreviewProvider {
  static var previews: some View {
    ProspectsView(filter: .none)
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
