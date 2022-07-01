//
//  RouteDetailsView.swift
//  Airlux
//
//  Created by Keane Hui on 2/7/2022.
//

import SwiftUI
import MapKit
import CoreLocation


struct RouteDetailsView: View {
    var route: Route
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            RouteCardView(route: route, isSimple: true)
            RouteDetailsMapView(route: route)
                .frame(height: 450)
                .cornerRadius(20)
            Spacer()
        }
        .padding()
        .navigationTitle("Route Preview")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RouteDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RouteDetailsView(route: Route.samples[0])
    }
}
