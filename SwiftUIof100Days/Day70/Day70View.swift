//
//  Day70View.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/13.
//

import MapKit
import SwiftUI

// MARK: - Day70View

struct Day70View: View {
  @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
  @State private var locations: [Day70View.Location] = []
  @State private var seletedPlace: Location?

  var body: some View {
    ZStack {
      Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
        MapAnnotation(coordinate: location.coordinate) {
          VStack {
            Image(systemName: "star.circle")
              .resizable()
              .foregroundColor(.red)
              .frame(width: 44, height: 44)
              .background(.white)
              .clipShape(Circle())

            Text(location.name)
              .fixedSize()
          }
          .onTapGesture {
            seletedPlace = location
          }
        }
      }
      .ignoresSafeArea()

      Circle()
        .fill(.blue)
        .opacity(0.3)
        .frame(width: 32, height: 32)

      VStack {
        Spacer()
        HStack {
          Spacer()
          Button {
            let new = Location(id: UUID(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)

            locations.append(new)
          } label: {
            Image(systemName: "plus")
          }
          .padding()
          .background(.black.opacity(0.75))
          .foregroundColor(.white)
          .font(.title)
          .clipShape(Circle())
          .padding(.trailing)
        }
      }
    }
    .sheet(item: $seletedPlace) { place in
      EditView(location: place) { newLocation in
        if let index = locations.firstIndex(of: place) {
          locations[index] = newLocation
        }
      }
    }
  }
}

// MARK: - Day70View_Previews

struct Day70View_Previews: PreviewProvider {
  static var previews: some View {
    Day70View()
  }
}

// MARK: - Location Model

extension Day70View {
  struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
      CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Where Queen Elizabeth lives with her dorgis.", latitude: 51.501, longitude: -0.141)

    static func == (lhs: Location, rhs: Location) -> Bool {
      lhs.id == rhs.id
    }
  }
}
