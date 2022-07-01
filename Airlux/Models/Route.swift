//
//  Route.swift
//  Airlux
//
//  Created by Keane Hui on 1/7/2022.
//

import Foundation
import MapKit
import CoreLocation

struct Route {
    var start: String
    var end: String
    var startXY: CLLocationCoordinate2D
    var endXY: CLLocationCoordinate2D
    var distance: Int = 0
    var picture: String = ""
}

extension Route {
    
    static let samples: [Route] = [
        Route(start: "Sha Tin", end: "Tai Mei Tuk", startXY: CLLocationCoordinate2D(latitude: 22.37794770661711, longitude: 114.19915329827472), endXY: CLLocationCoordinate2D(latitude: 22.46777855425025, longitude: 114.23648836090771), distance: 22, picture: "shatin-taimeituk"),
        Route(start: "Sha Tin", end: "Wu Kai Sha", startXY: CLLocationCoordinate2D(latitude: 22.37794770661711, longitude: 114.19915329827472), endXY: CLLocationCoordinate2D(latitude: 22.429266234638426, longitude: 114.23477232421963), distance: 8, picture: "shatin-wukaisha"),
        Route(start: "Yuen Long", end: "Nam Sang Wai", startXY: CLLocationCoordinate2D(latitude: 22.446027469048644, longitude: 114.03483951354555), endXY: CLLocationCoordinate2D(latitude: 22.469166986088283, longitude: 114.03026386996575), distance: 20, picture: "yuenlong-namsangwai")
    ]
    
}
