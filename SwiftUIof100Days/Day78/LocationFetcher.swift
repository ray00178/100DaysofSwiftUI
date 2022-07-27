//
//  LocationFetcher.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/7/27.
//

import Foundation
import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
  
  let manager = CLLocationManager()
  var lastKnownLocation: CLLocationCoordinate2D?
  
  override init() {
    super.init()
    manager.delegate = self
  }
  
  func start() {
    manager.requestWhenInUseAuthorization()
    manager.startUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    lastKnownLocation = locations.first?.coordinate
  }
}
