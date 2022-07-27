//
//  Day78View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/27.
//

import SwiftUI
import CoreLocation

// MARK: - Day78View

struct Day78View: View {
  
  @State private var location: CLLocationCoordinate2D?
  
  let locationFetcher = LocationFetcher()

  var body: some View {
    VStack(spacing: 20.0) {
      Button("Start Tracking Location") {
        locationFetcher.start()
      }
      .padding()

      Button("Read Location：\(location.debugDescription)") {
        if let location = self.locationFetcher.lastKnownLocation {
          self.location = location
        } else {
          location = nil
        }
      }
      .padding()
    }
  }
}

// MARK: - Day78View_Previews

struct Day78View_Previews: PreviewProvider {
  static var previews: some View {
    Day78View()
  }
}
