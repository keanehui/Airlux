//
//  ContentView.swift
//  Airlux
//
//  Created by Keane Hui on 26/6/2022.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct HomeView: View {
    
    @StateObject private var locationVM = LocationViewModel()
    
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.9
    @State private var draggingOffsetY: CGFloat = 0.0
    @State private var isAnimationUp: Bool = false
    @State private var isTouched: Bool = false
    
    let offsetYDown: CGFloat = UIScreen.main.bounds.height * 0.9
    let offsetYUp: CGFloat = UIScreen.main.bounds.height * 0.15
    let dragCoefficient: CGFloat = 0.7
    
    var body: some View {
        ZStack {
            mapView
                .onTapGesture {
                    if startingOffsetY == offsetYUp {
                        withAnimation(.spring()) {
                            startingOffsetY = offsetYDown
                        }
                    }
                }
            drawerView
        }
    }
}

extension HomeView {
    
    private var drawerView: some View {
        ZStack(alignment: .top) {
            drawerBoard
            MenuView()
                .padding(.top, 50)
        }
        .ignoresSafeArea(edges: .bottom)
        .offset(y: startingOffsetY)
        .offset(y: draggingOffsetY)
        .offset(y: isAnimationUp ? -40 : 0)
        .animation(.easeInOut(duration: 1.0), value: isAnimationUp)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                if !isTouched {
                    withAnimation {
                        isAnimationUp = true
                        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                            isAnimationUp = false
                        }
                    }
                }
            }
        }
        .onChange(of: draggingOffsetY) { newValue in
            isTouched = true
        }
        .gesture(
            DragGesture()
                .onChanged({ value in
                    withAnimation(.easeOut(duration: 0.5)) {
                        if startingOffsetY == offsetYUp {
                            draggingOffsetY = max(value.translation.height * dragCoefficient, -40)
                        } else { // startingOffsetY == offsetYDown
                            draggingOffsetY = min(value.translation.height * dragCoefficient, 15)
                        }
                    }
                })
                .onEnded({ value in
                    withAnimation(.spring()) {
                        if startingOffsetY == offsetYDown && draggingOffsetY < -50.0 {
                           startingOffsetY = offsetYUp
                        } else if startingOffsetY == offsetYUp && draggingOffsetY > 50.0 {
                            startingOffsetY = offsetYDown
                        }
                        draggingOffsetY = 0.0
                    }
                })
        )
    }
    
    private var drawerBoard: some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+50)
            .foregroundStyle(.thinMaterial)
            .overlay(alignment: .top) {
                Capsule()
                    .frame(width: 40, height: 5)
                    .foregroundStyle(.secondary)
                    .padding(.top, 10)
            }
    }
    
    private var mapView: some View {
        Map(coordinateRegion: $locationVM.region, showsUserLocation: true)
            .ignoresSafeArea(edges: .all)
//            .overlay(alignment: .topTrailing) {
//                LocationButton(.currentLocation) {
//                    print("requesting to update location...")
//                    withAnimation {
//                        locationVM.requestLocation()
//                    }
//                }
//                .foregroundColor(.white)
//                .cornerRadius(15)
//                .labelStyle(.iconOnly)
//                .symbolVariant(.fill)
//                .padding()
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
