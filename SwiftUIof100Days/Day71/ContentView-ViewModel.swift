//
//  ContentView-ViewModel.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/19.
//

import LocalAuthentication
import MapKit

extension Day70View {
  @MainActor class ViewModel: ObservableObject {
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    @Published private(set) var locations: [Day70View.Location]
    @Published var selectedPlace: Day70View.Location?
    @Published var isUnlocked: Bool = false

    let savePath = FileManager.documentsDictionary.appendingPathComponent("SavedPlaces")

    init() {
      do {
        let data = try Data(contentsOf: savePath)
        locations = try JSONDecoder().decode([Location].self, from: data)
      } catch {
        locations = []
      }
    }

    func addLocation() {
      let newLocation = Day70View.Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
      locations.append(newLocation)

      save()
    }

    func upload(location: Day70View.Location) {
      guard let selectedPlace = selectedPlace else { return }

      if let index = locations.firstIndex(of: selectedPlace) {
        locations[index] = location

        save()
      }
    }

    func save() {
      do {
        let data = try JSONEncoder().encode(locations)
        try data.write(to: savePath, options: [.atomic, .completeFileProtection])
      } catch {
        print("Unable to save data.")
      }
    }

    func authenticate() {
      let context = LAContext()
      var error: NSError?

      if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        let reason = "Please authenticate yourself to unlock your places."

        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                               localizedReason: reason)
        { success, _ in
          if success {
            /*Task {
              await MainActor.run(body: {
                self.isUnlocked = true
              })
            }*/
            
            // or
            
            Task { @MainActor in
              self.isUnlocked = true
            }
          } else {
            // error
          }
        }
      } else {
        // no biometrics
      }
    }
  }
}
