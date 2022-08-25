//
//  Day96View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/25.
//

import SwiftUI

// MARK: - Day96View

struct Day96View: View {
  var body: some View {
    NavigationView {
      NavigationLink {
        if #available(iOS 16.0, *) {
          Text("New secondary")
            .toolbar(.hidden)
        } else {
          Text("New secondary")
            .navigationBarHidden(true)
        }
      } label: {
        Text("Hello, World!")
      }
      .navigationTitle("Primary")
    }
    
    Text("Secondary")
  }
}

// MARK: - Day96View_Previews

struct Day96View_Previews: PreviewProvider {
  static var previews: some View {
    Day96View()
  }
}
