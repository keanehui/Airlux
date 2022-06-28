//
//  MenuView.swift
//  Airlux
//
//  Created by Keane Hui on 27/6/2022.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                MetroBlock(color: .green, text: "Start", image: "bicycle", size: .Large)
                MetroBlock(color: .cyan, text: "History", image: "list.bullet.indent", size: .Medium)
            }.padding(.bottom, 7)
            HStack(spacing: 15) {
                MetroBlock(color: .red, text: "Routes", image: "arrow.triangle.swap",size: .XLarge)
            }
            .padding(.bottom, 30)
            
            HStack(spacing: 15) {
                MetroBlock(color: .teal, text: "AQI", image: "wind", size: .Medium)
                MetroBlock(color: .blue, text: "Weather", image: "cloud.sun", size: .Medium)
                MetroBlock(color: .orange, text: "Traffic", image: "bus", size: .Medium)
            }
            .padding(.bottom, 30)
            
            HStack(spacing: 15) {
                MetroBlock(color: .yellow, text: "Favorites", image: "star", size: .Medium)
                MetroBlock(color: .purple, text: "Community", image: "house", size: .Large)
            }.padding(.bottom, 7)
            HStack(spacing: 15) {
                MetroBlock(color: .cyan, text: "Reviews", image: "star.bubble.fill", size: .Medium)
                MetroBlock(color: .indigo, text: "Add frd", image: "person.badge.plus", size: .Medium)
                MetroBlock(color: .indigo, text: "Frends", image: "person.3", size: .Medium)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct MetroBlock: View {
    var color: Color
    var text: String = ""
    var image: String = ""
    var size: MetroBlockSize
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: size.rawValue, height: 100)
                .foregroundColor(color)
                .overlay(alignment: .bottomLeading) {
                    Text(text)
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                        .padding(.leading, 15)
                        .foregroundColor(.white)
                }
            Image(systemName: image)
                .foregroundColor(.white)
                .font(.system(size: size == .XLarge ? 45 : 38, weight: .bold, design: .rounded))
                .padding(.bottom, 15)
        }
    }
}

enum MetroBlockSize: CGFloat {
    case Medium = 100
    case Large = 215
    case XLarge = 330
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
