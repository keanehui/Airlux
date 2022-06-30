//
//  MapView.swift
//  Airlux
//
//  Created by Keane Hui on 29/6/2022.
//

import Foundation
import UIKit
import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    var region: MKCoordinateRegion
    var showTraffic: Bool
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView(frame: .zero)
        map.setRegion(region, animated: true)
        map.showsTraffic = showTraffic
        print("Map Representable built")
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
//        uiView.setRegion(region, animated: true)
        uiView.showsTraffic = showTraffic
    }
}

extension MKCoordinateRegion {
    func isSameAs(region: MKCoordinateRegion) -> Bool {
        let coor1: CLLocationCoordinate2D = self.center
        let coor2: CLLocationCoordinate2D = region.center
        if coor1.latitude == coor2.latitude && coor1.longitude == coor2.longitude {
            return true
        }
        return false
    }
}

