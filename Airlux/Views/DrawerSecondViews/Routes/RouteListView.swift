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
            Text("Today's Featured")
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

struct RouteListView_Previews: PreviewProvider {
    static var previews: some View {
        RouteListView(content: .constant(.Routes), isDrawerUp: .constant(false), isSheetUp: .constant(true))
    }
}
