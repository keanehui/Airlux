//
//  RouteListView.swift
//  Airlux
//
//  Created by Keane Hui on 2/7/2022.
//

import SwiftUI

struct RouteListView: View {
    @Binding var content: MenuButtonType
    @Binding var isDrawerUp: Bool
    @Binding var isSheetUp: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                routeListHeader
                ScrollView(.vertical) {
                    Group {
                        ForEach(Route.samples, id: \.picture) { route in
                            RouteCardView(route: route)
                                .padding(.vertical)
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

extension RouteListView {
    
    private var routeListHeader: some View {
        HStack {
            Text("Popular Routes")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer()
            Button {
                withAnimation {
                    isSheetUp = false
                    isDrawerUp = true
                }
                content = .Menu
            } label: {
                Image(systemName: "multiply")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.blue, in: Circle())
                    .font(.system(size: 15, weight: .bold, design: .rounded))
            }
        }
    }
    
}

struct RouteCardView: View {
    var route: Route
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.red)
            VStack {
                dottedLine
                distanceIndicator
                startAndEnd
                Button {
                    
                } label: {
                    HStack {
                        Text("Preview Route")
                            .bold()
                            .foregroundColor(.white)
                            .font(.title3)
                        Image(systemName: "greaterthan")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .padding(10)
                    .background(.teal, in: RoundedRectangle(cornerRadius: 15))
                    
                }
                Image(route.picture)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFit()
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 17)
                                .stroke(Color.white, lineWidth: 5))
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 410)
    }
    
    private var dottedLine: some View {
        HStack(spacing: 30) {
            Circle()
                .stroke(lineWidth: 5)
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
            ForEach(0..<5) { i in
                Circle()
                    .fill(.white)
                    .frame(width: 10, height: 10)
                    .foregroundColor(.white)
            }
            Image(systemName: "mappin.and.ellipse")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .scaleEffect(1.3)
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
    }
    
    private var distanceIndicator: some View {
        HStack(alignment: .center) {
            Text("\(route.distance) km")
                .bold()
                .font(.title3)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var startAndEnd: some View {
        HStack {
            Text(route.start)
                .bold()
            Spacer()
            Text(route.end)
                .bold()
        }
        .font(.title2)
        .foregroundColor(.white)
        .padding(.horizontal)
    }
}

struct RouteListView_Previews: PreviewProvider {
    static var previews: some View {
        RouteListView(content: .constant(.Routes), isDrawerUp: .constant(false), isSheetUp: .constant(true))
//        RouteCardView(route: Route.samples[0])
    }
}
