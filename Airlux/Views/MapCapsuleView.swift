//
//  MapCapsuleView.swift
//  Airlux
//
//  Created by Keane Hui on 30/6/2022.
//

import SwiftUI

struct MapCapsuleView: View {
    var text: String
    var onTap: (() -> ())?
    
    var body: some View {
        HStack {
            Text(text)
                .bold()
                .foregroundColor(.blue)
            Divider()
                .frame(maxHeight: 30)
            Button {
                onTap?()
            } label: {
                Image(systemName: "multiply")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding(6)
                    .foregroundColor(.gray)
            }
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
    }
}

struct MapCapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        MapCapsuleView(text: "Traffic Map")
    }
}
