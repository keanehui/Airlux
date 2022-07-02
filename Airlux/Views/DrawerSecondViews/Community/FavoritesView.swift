//
//  FavoritesView.swift
//  Airlux
//
//  Created by Keane Hui on 2/7/2022.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var content: MenuButtonType
    @Binding var isDrawerUp: Bool
    @Binding var isSheetUp: Bool
    var isShortCut: Bool = false
    
    var body: some View {
        VStack {
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
        .navigationBarHidden(isShortCut)
        .navigationTitle("Favorites")
        .padding(.top, isShortCut ? 65 : 0)
        .overlay(alignment: .topTrailing) {
            if isShortCut {
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
                        .padding([.top, .horizontal])
                }
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(content: .constant(.AddFrd), isDrawerUp: .constant(false), isSheetUp: .constant(true))
    }
}
