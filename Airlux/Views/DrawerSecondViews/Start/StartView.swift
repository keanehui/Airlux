//
//  StartView.swift
//  Airlux
//
//  Created by Keane Hui on 2/7/2022.
//

import SwiftUI

struct StartView: View {
    @Binding var content: MenuButtonType
    @Binding var isDrawerUp: Bool
    @Binding var isSheetUp: Bool
    
    @State private var target: Double = 18
    @State private var isSet: Bool = false
    
    var body: some View {
        VStack {
            startHeader
            goalBox
                .padding(.bottom, 10)
            CircularMapView()
                .cornerRadius(15)
                .opacity(isSet ? 1.0 : 0.0)
                .animation(.easeInOut, value: isSet)
                .frame(maxWidth: .infinity, maxHeight: 400)
        }
        .padding()
    }
}

extension StartView {
    
    private var startHeader: some View {
        HStack {
            Text("Start")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer()
            Button {
                content = .Menu
                withAnimation {
                    isSheetUp = false
                    isDrawerUp = true
                }
            } label: {
                Image(systemName: "multiply")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.blue, in: Circle())
                    .font(.system(size: 15, weight: .bold, design: .rounded))
            }
        }
    }
    
    private var goalBox: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.ultraThickMaterial)
            VStack(spacing: 0) {
                infoBlock
                HStack {
                    VStack(spacing: 2) {
                        HStack {
                            (Text("\(Int(target))").font(.title).bold()
                            + Text(" km").font(.caption2).bold())
                            .foregroundColor(.green)
                            Image(systemName: "bicycle")
                                .foregroundColor(.green)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                        }
                        
                        Slider(value: $target, in: 1...50, step: 1)
                            .padding(.horizontal)
                    }
                    VStack(spacing: 5) {
                        Spacer()
                        HStack(spacing: 5) {
                            Image(systemName: "clock.arrow.circlepath")
                                .font(.system(size: 10, weight: .light, design: .rounded))
                                .foregroundColor(.gray)
                            Text("16 km")
                                .font(.system(size: 10, weight: .light, design: .rounded))
                                .foregroundColor(.gray)
                        }
                        Button {
                            target = 22
                            isSet = true
                        } label: {
                            Text("Set")
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding(7)
                                .padding(.horizontal, 10)
                                .background(.green, in: RoundedRectangle(cornerRadius: 10))
                                .padding(.bottom)
                        }
                    }
                    .padding(.trailing)
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 220)
    }
    
    private var infoBlock: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Great day for a ride")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.mint)
                HStack(spacing: 5) {
                    Text("Sunny")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.mint)
                    Image(systemName: "sun.max.fill")
                        .foregroundColor(.yellow)
                }
                .padding(1)
                HStack {
                    HStack(spacing: 5) {
                        Image(systemName: "thermometer.snowflake")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(.blue)
                        Text("23")
                            .bold()
                            .font(.caption2)
                            .foregroundColor(.mint)
                    }
                    HStack(spacing: 5) {
                        Image(systemName: "thermometer.sun.fill")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(.red)
                        Text("26")
                            .bold()
                            .font(.caption2)
                            .foregroundColor(.mint
                            )
                    }
                }
            }
            .padding()
            Spacer()
            VStack {
                Text("31")
                    .font(.system(size: 37, weight: .bold, design: .rounded))
                    .foregroundColor(.teal)
                Text("AQI")
                    .font(.system(.subheadline, design: .rounded))
                    .bold()
                    .foregroundColor(.teal)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
    }
    
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(content: .constant(.Community), isDrawerUp: .constant(true), isSheetUp: .constant(true))
    }
}
