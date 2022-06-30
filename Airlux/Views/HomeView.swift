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
    
    // Map
    @State private var showTraffic: Bool = false
    
    // Drawer
    @State private var isDrawerUp: Bool = false
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.9
    @State private var draggingOffsetY: CGFloat = 0.0
    @State private var isAnimationUp: Bool = false
    @State private var isTouched: Bool = false
    
    let offsetYDown: CGFloat = UIScreen.main.bounds.height * 0.9
    let offsetYUp: CGFloat = UIScreen.main.bounds.height * 0.15
    let dragCoefficient: CGFloat = 0.7
    
    // Drawer Sheet Content
    @State private var content: MenuButtonType = .Menu
    @State private var isSheetUp: Bool = false
    
    var body: some View {
        ZStack(alignment: .center) {
            mapLayers
            drawer
            communitySheet
                .opacity(isSheetUp ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.3), value: isSheetUp)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onChange(of: isDrawerUp) { newValue in
            withAnimation(.spring()) {
                setDrawerUp(newValue)
            }
        }
        .onChange(of: content) { newValue in
            onChangeDrawerContent(newValue: newValue)
        }
    }
}

extension HomeView {
    
    private var communitySheet: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0.0)
                .frame(width: UIScreen.main.bounds.width, height: 900)
                .foregroundColor(.white)
            CommunityView(content: $content, isDrawerUp: $isDrawerUp, isSheetUp: $isSheetUp)
                .padding(.top, 100)
                .padding(.bottom, 100)
        }
    }
    
    private func resetMap() {
        withAnimation {
            isDrawerUp = false
            content = .Menu
        }
    }
    
    private func setDrawerUp(_ isUp: Bool) { // use isDrawerUp instead
        withAnimation(.spring()) {
            if isUp {
                startingOffsetY = offsetYUp
            } else {
                startingOffsetY = offsetYDown
            }
        }
    }
    
    private func onChangeDrawerContent(newValue: MenuButtonType) {
        switch newValue {
        case .Menu:
            showTraffic = false
        case .Traffic:
            withAnimation {
                showTraffic = true
            }
        case .Community:
            withAnimation {
                isSheetUp = true
            }
        default:
            print()
        }
    }
    
    private var drawer: some View {
        ZStack(alignment: .top) {
            drawerBoard
            MenuView(content: $content, isDrawerUp: $isDrawerUp)
                .padding(.top, 50)
//            DrawerContentView(content: $content, isDrawerUp: $isDrawerUp)
//                .padding(.top, 50)
        }
        .offset(y: startingOffsetY)
        .offset(y: draggingOffsetY)
        .offset(y: isAnimationUp ? -60 : 0)
        .animation(.interactiveSpring(response: 0.7, dampingFraction: 0.235, blendDuration: 0), value: isAnimationUp)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                if !isTouched {
                    withAnimation {
                        isAnimationUp = true
                    }
                }
            }
        }
        .gesture(
            DragGesture()
                .onChanged({ value in
                    withAnimation(.spring()) {
                        isTouched = true
                        isAnimationUp = false
                        if isDrawerUp {
                            draggingOffsetY = max(value.translation.height * dragCoefficient, -40)
                        } else {
                            draggingOffsetY = min(value.translation.height * dragCoefficient, 15)
                        }
                    }
                })
                .onEnded({ value in
                    withAnimation(.spring()) {
                        if !isDrawerUp && draggingOffsetY < -50.0 {
                           isDrawerUp = true
                        } else if isDrawerUp && draggingOffsetY > 50.0 {
                            isDrawerUp = false
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
    
    private var mapLayers: some View {
        ZStack {
            MapView(region: locationVM.region, showTraffic: showTraffic)
            AQIMapView()
                .opacity(content == .AQI ? 1.0 : 0.0)
            PollenMapView()
                .opacity(content == .Pollen ? 1.0 : 0.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) {
            switch content {
            case .AQI:
                MapCapsuleView(text: "AQI Map", onTap: resetMap)
                    .transition(.opacity.animation(.easeOut))
                    .padding(.top, 100)
            case .Pollen:
                MapCapsuleView(text: "Pollen Map", onTap: resetMap)
                    .transition(.opacity.animation(.easeOut))
                    .padding(.top, 100)
            case .Traffic:
                MapCapsuleView(text: "Traffic Map", onTap: resetMap)
                    .transition(.opacity.animation(.easeOut))
                    .padding(.top, 100)
            default:
                Text("No capsule")
            }
            
        }
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
