//
//  MenuView.swift
//  Airlux
//
//  Created by Keane Hui on 27/6/2022.
//

import SwiftUI

struct DrawerContentView: View {
    @Binding var content: DrawerContentPage
    @Binding var isDrawerUp: Bool
    
    var body: some View {
        switch content {
        case .Menu:
            MenuView(content: $content, isDrawerUp: $isDrawerUp)
        case .AQI:
            AQIView()
        case .Traffic:
            MenuView(content: $content, isDrawerUp: $isDrawerUp)
        default:
            Text("No view")
        }
    }
}

enum DrawerContentPage: Int {
    case Menu
    
    case Start
    case History
    case Routes
    
    case AQI
    case Weather
    case Traffic
    
    case Community
    case Favorites
    case Reviews
    case AddFrd
    case Friends
}

struct DrawerContentView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerContentView(content: .constant(.Menu), isDrawerUp: .constant(false))
    }
}
