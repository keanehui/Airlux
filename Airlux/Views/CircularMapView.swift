//
//  CircularMapView.swift
//  Airlux
//
//  Created by Keane Hui on 2/7/2022.
//

import UIKit
import SwiftUI
import MapKit
import CoreLocation

struct CircularMapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    let p1: MKPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 22.428346401912705, longitude: 114.21390898661403)) // HKSTP
    var p2: MKPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 22.377308626512846, longitude: 114.19708371458825)) // Sha Tin
    var p3: MKPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 22.407566627930763, longitude: 114.22165948366957)) // Mui Tsz Lam Tsuen
    
    func makeUIView(context: Context) -> MKMapView {
        let p1Annotation = MKPointAnnotation()
        p1Annotation.title = "HKSTP"
        p1Annotation.coordinate = p1.coordinate
        
        let p2Annotation = MKPointAnnotation()
        p2Annotation.title = "Sha Tin"
        p2Annotation.coordinate = p2.coordinate
        
        let p3Annotation = MKPointAnnotation()
        p3Annotation.title = "Mui Tsz Lam Tsuen"
        p3Annotation.coordinate = p3.coordinate
        
        let map = MKMapView(frame: .zero)
        map.delegate = context.coordinator
        // p1 -> p2
        let request1 = MKDirections.Request()
        request1.source = MKMapItem(placemark: p1)
        request1.destination = MKMapItem(placemark: p2)
        request1.transportType = .automobile
        let directions1 = MKDirections(request: request1)
        directions1.calculate { response, error in
            guard let route = response?.routes.first else { return }
            map.addAnnotation(p1Annotation)
            map.addAnnotation(p2Annotation)
            map.addAnnotation(p3Annotation)
            map.addOverlay(route.polyline)
        }
        
        // p2 -> p3
        let request2 = MKDirections.Request()
        request2.source = MKMapItem(placemark: p2)
        request2.destination = MKMapItem(placemark: p3)
        request2.transportType = .automobile
        let directions2 = MKDirections(request: request2)
        directions2.calculate { response, error in
            guard let route = response?.routes.first else { return }
            map.addAnnotation(p1Annotation)
            map.addAnnotation(p2Annotation)
            map.addOverlay(route.polyline)
        }
        
        // p3 -> p1
        let request3 = MKDirections.Request()
        request3.source = MKMapItem(placemark: p3)
        request3.destination = MKMapItem(placemark: p1)
        request3.transportType = .automobile
        let directions3 = MKDirections(request: request3)
        directions3.calculate { response, error in
            guard let route = response?.routes.first else { return }
            map.addAnnotation(p1Annotation)
            map.addAnnotation(p2Annotation)
            map.addOverlay(route.polyline)
        }
        map.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.40569522724577, longitude: 114.20727923879144), span: MKCoordinateSpan(latitudeDelta: 0.065, longitudeDelta: 0.065)), animated: true)
        print("Map Representable built")
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {

    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
    }
}

