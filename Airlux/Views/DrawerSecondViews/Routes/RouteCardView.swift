//
//  SwiftUIView.swift
//  Airlux
//
//  Created by Keane Hui on 2/7/2022.
//

import SwiftUI

struct RouteCardView: View {
    var route: Route
    var isSimple: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(isSimple ? .teal : .red)
            VStack {
                dottedLine
                startAndEnd
                HStack(spacing: 50) {
                    if isSimple {
                        VStack {
                            Text("\(route.AQI)")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.white)
                                .overlay(alignment: .trailing) {
                                    Circle()
                                        .fill(route.AQIColor)
                                        .frame(width: 8)
                                        .overlay(Circle().stroke(Color.white, lineWidth: 0.5))
                                        .offset(x: 10)
                                }
                            Text("AQI")
                                .font(.caption2)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                    Text("\(route.distance) km")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    if isSimple {
                        VStack {
                            HStack(spacing: 0) {
                                Text("\(route.rating)")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.white)
                                Text("/3")
                                    .font(.system(size: 10, weight: .regular, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            Text("rating")
                                .font(.caption2)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                    if !isSimple {
                        NavigationLink {
                            RouteDetailsView(route: route)
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
                    }
                }
                
                if !isSimple {
                    Image(route.picture)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .cornerRadius(20)
                        .overlay(RoundedRectangle(cornerRadius: 17)
                                    .stroke(Color.white, lineWidth: 5))
                        .padding()
                        .overlay(alignment: .topLeading) {
                            HStack(spacing: 10) {
                                VStack {
                                    Text("\(route.AQI)")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text("AQI")
                                        .font(.caption2)
                                        .bold()
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(.green, in: Circle())
                                HStack {
                                    Group {
                                        Image(systemName: "star.fill")
                                        Image(systemName: "star.fill")
                                        if route.rating == 2 {
                                            Image(systemName: "star")
                                        } else if route.rating == 3 {
                                            Image(systemName: "star.fill")
                                        }
                                    }
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                }
                                .foregroundColor(.yellow)
                            }
                            .offset(x: 25, y: 20)
                        }
                }
            }
        }
        .frame(height: isSimple ? 160 : 385)
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
    
    private var startAndEnd: some View {
        HStack {
            Text(route.start)
                .bold()
            Spacer()
            Image(systemName: "arrow.right")
                .font(.system(size: 20, weight: .bold, design: .rounded))
            Spacer()
            Text(route.end)
                .bold()
        }
        .font(.title2)
        .foregroundColor(.white)
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}

struct RouteCardView_Previews: PreviewProvider {
    static var previews: some View {
        RouteCardView(route: Route.samples[0])
    }
}
