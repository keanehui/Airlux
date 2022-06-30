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
    
    // Drawer Content
    @State private var content: DrawerContentPage = .Menu
    
    var body: some View {
        ZStack {
            mapLayer
            drawer
        }
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
    
    private func onChangeDrawerContent(newValue: DrawerContentPage) {
        switch newValue {
        case .Menu:
            showTraffic = false
        case .Traffic:
            withAnimation {
                showTraffic = true
            }
        default:
            print("no action")
        }
    }
    
    private var drawer: some View {
        ZStack(alignment: .top) {
            drawerBoard
            DrawerContentView(content: $content, isDrawerUp: $isDrawerUp)
                .padding(.top, 50)
        }
        .ignoresSafeArea(edges: .bottom)
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
    
    private var mapLayer: some View {
        MapView(region: locationVM.region, showTraffic: showTraffic)
            .ignoresSafeArea(edges: .all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .top) {
                if content == .Traffic {
                    MapCapsuleView(text: "Traffic Map", onTap: resetMap)
                        .transition(.opacity.animation(.easeOut))
                        .padding(.top, 65)
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
