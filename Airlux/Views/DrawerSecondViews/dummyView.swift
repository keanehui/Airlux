//
//  dummyView.swift
//  Airlux
//
//  Created by Keane Hui on 30/6/2022.
//

import SwiftUI

struct dummyView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: 100, weight: .bold, design: .rounded))
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.red)
                
        }
    }
}

struct dummyView_Previews: PreviewProvider {
    static var previews: some View {
        dummyView()
    }
}
