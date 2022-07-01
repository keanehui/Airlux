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
                .frame(height: 480)
                .cornerRadius(20)
                .overlay(alignment: .topLeading) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "star")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.gray)
                            .padding()
                            .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 15))
                            .padding()
                    }
                    
                }
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
