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
    
    @State private var isPresentedAdd: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            RouteCardView(route: route, isSimple: true)
            RouteDetailsMapView(route: route)
                .frame(height: 390)
                .cornerRadius(20)
                .overlay(alignment: .topLeading) {
                    Button(action: {
                        isPresentedAdd = true
                    }) {
                        Image(systemName: "star")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.gray)
                            .padding()
                            .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 15))
                            .padding()
                    }
                    
                }
                .alert("Added to Forvorites", isPresented: $isPresentedAdd, actions: {})
            Button {
                
            } label: {
                Text("Start")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(25)
                    .background(.green, in: Circle())
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
