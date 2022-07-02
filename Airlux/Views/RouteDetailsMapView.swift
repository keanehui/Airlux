//
//  RouteDetailsMapView.swift
//  Airlux
//
//  Created by Keane Hui on 2/7/2022.
//

import UIKit
import SwiftUI
import MapKit
import CoreLocation

struct RouteDetailsMapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    var route: Route
    var p1: MKPlacemark {
        MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: route.startXY.latitude, longitude: route.startXY.longitude))
    }
    var p2: MKPlacemark {
        MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: route.endXY.latitude, longitude: route.endXY.longitude))
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let p1Annotation = MKPointAnnotation()
        p1Annotation.title = route.start
        p1Annotation.coordinate = p1.coordinate
        
        let p2Annotation = MKPointAnnotation()
        p2Annotation.title = route.end
        p2Annotation.coordinate = p2.coordinate
        
        let map = MKMapView(frame: .zero)
        map.delegate = context.coordinator
        map.setRegion(MKCoordinateRegion(center: p1.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            map.addAnnotation(p1Annotation)
            map.addAnnotation(p2Annotation)
            map.addOverlay(route.polyline)
            map.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 40, left: 20, bottom: 40, right: 20), animated: true)
        }
    
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

