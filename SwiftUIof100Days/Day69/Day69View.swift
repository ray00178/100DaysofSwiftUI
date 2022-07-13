//
//  Day69View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/11.
//

import LocalAuthentication
import MapKit
import SwiftUI

// MARK: - Day69View

struct Day69View: View {
  @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
  
  @State private var isUnlocked = false
  
  let locations: [Location] = [
    Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
    Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076)),
  ]

  var body: some View {
    NavigationView {
      ZStack(alignment: .bottom) {
        Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
          MapAnnotation(coordinate: location.coordinate) {
            NavigationLink {
              Text(location.name)
                .foregroundColor(.blue)
                .padding()
                .font(.system(size: 20, design: .monospaced))
            } label: {
              Circle()
                .stroke(.red, lineWidth: 3)
                .frame(width: 44, height: 33)
            }
          }
        }
        
        if isUnlocked {
          Text("Unlocked")
            .padding(20)
            .background(.white)
            .cornerRadius(4)
        } else {
          Text("Locked")
            .padding(20)
            .background(.white)
            .cornerRadius(4)
        }
      }
      .navigationTitle("London Explorer")
      .ignoresSafeArea(edges: .bottom)
      .onAppear(perform: authenticate)
    }
  }

  func authenticate() {
    let context = LAContext()
    var error: NSError?

    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "We need to unlock your data."

      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
        isUnlocked = success
        
        if success {
          // authenticated successfully
        } else {
          // there was a problem
        }
      }
    } else {
      // no biometrics
    }
  }
}

// MARK: - Day69View_Previews

struct Day69View_Previews: PreviewProvider {
  static var previews: some View {
    Day69View()
  }
}

// MARK: - Location

struct Location: Identifiable {
  let id = UUID()
  let name: String
  let coordinate: CLLocationCoordinate2D
}
