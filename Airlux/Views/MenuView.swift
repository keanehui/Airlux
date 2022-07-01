//
//  MenuView.swift
//  Airlux
//
//  Created by Keane Hui on 29/6/2022.
//

import SwiftUI

struct MenuView: View {
    @Binding var content: MenuButtonType
    @Binding var isDrawerUp: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(spacing: 15) {
                MetroBlock(color: .green, text: "Start", image: "bicycle", size: .Medium)
                MetroBlock(color: .cyan, text: "History", image: "list.bullet.indent", size: .Small)
            }.padding(.bottom, 7)
            HStack(spacing: 15) {
                MetroBlock(color: .red, text: "Routes", image: "arrow.triangle.swap",size: .Large)
            }
            .padding(.bottom, 30)
            
            HStack(spacing: 15) {
                Button {
                    content = .AQI
                    isDrawerUp = false
                } label: {
                    MetroBlock(color: .teal, text: "AQI", image: "wind", size: .Small)
                }
                Button {
                    content = .Pollen
                    isDrawerUp = false
                } label: {
                    MetroBlock(color: .blue, text: "Pollen", image: "allergens", size: .Small)
                }
                Button {
                    content = .Traffic
                    isDrawerUp = false
                } label: {
                    MetroBlock(color: .orange, text: "Traffic", image: "bus", size: .Small)
                }
            }
            .padding(.bottom, 30)
            
            HStack(spacing: 15) {
                MetroBlock(color: .yellow, text: "Favorites", image: "star", size: .Small)
                Button {
                    content = .Community
                    isDrawerUp = false
                } label: {
                    MetroBlock(color: .purple, text: "Community", image: "house", size: .Medium)
                }

            }.padding(.bottom, 7)
            HStack(spacing: 15) {
                MetroBlock(color: .cyan, text: "Reviews", image: "star.bubble.fill", size: .Small)
                Button {
                    content = .AddFrd
                    isDrawerUp = false
                } label: {
                    MetroBlock(color: .indigo, text: "Add frd", image: "person.badge.plus", size: .Small)
                }
                Button {
                    content = .Friends
                    isDrawerUp = false
                } label: {
                    MetroBlock(color: .indigo, text: "Frends", image: "person.3", size: .Small)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                .font(.system(size: size == .Small ? 38 : 45, weight: .bold, design: .rounded))
                .padding(.bottom, 15)
        }
    }
}

enum MetroBlockSize: CGFloat {
    case Small = 100
    case Medium = 215
    case Large = 330
}

enum MenuButtonType: Int {
    case Menu

    case Start
    case History
    case Routes

    case AQI
    case Pollen
    case Traffic

    case Community
    case Favorites
    case Reviews
    case AddFrd
    case Friends
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(content: .constant(.Menu), isDrawerUp: .constant(false))
    }
}
