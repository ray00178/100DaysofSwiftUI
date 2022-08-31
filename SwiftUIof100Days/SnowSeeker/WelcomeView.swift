//
//  WelcomeView.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/8/29.
//

import SwiftUI

// MARK: - WelcomeView

struct WelcomeView: View {
  var body: some View {
    VStack {
      Text("Welcome to SnowSeeker!")
        .font(.largeTitle)

      Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
        .foregroundColor(.secondary)
    }
  }
}

// MARK: - WelcomeView_Previews

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}
