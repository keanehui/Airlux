//
//  LocationViewModel.swift
//  Airlux
//
//  Created by Keane Hui on 26/6/2022.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

final class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.4263162384, longitude: 114.211648397), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        DispatchQueue.main.async {
            withAnimation {
                self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                print("region updated: \t\(location.coordinate.latitude) \t\(location.coordinate.longitude)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
