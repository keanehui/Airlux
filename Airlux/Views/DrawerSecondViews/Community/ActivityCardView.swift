//
//  ActivityCardView.swift
//  Airlux
//
//  Created by Keane Hui on 30/6/2022.
//

import SwiftUI

struct ActivityCardView: View {
    var type: ActivtyCardType
    var icon: String
    var name: String
    var message: String
    var messageAge: Int = 0
    var boxHeight: CGFloat = 100
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(type == .Friend ? Color(red: 0.73, green: 0.99, blue: 0.31) : .pink)
                .overlay(alignment: .bottomTrailing) {
                    Text(messageAge == 0 ? "now" : "\(messageAge)m ago")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundColor(type == .Friend ? .gray : .white)
                        .padding(10)
                }
            HStack {
                CardIconAndName(type: type, icon: icon, name: name)
                    .padding(.horizontal)
                    .offset(x: 0, y: -15)
                VStack(alignment: .leading) {
                    Text(message)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .foregroundColor(type == .Friend ? .black : .white)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .padding([.top, .trailing], 7)
                    
                    Button {
                        // show route
                    } label: {
                        Text("Show Details")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(type == .Friend ? .blue : .yellow)
                            .padding(.vertical, 10)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: boxHeight)
        .padding(.vertical, 15)
    }
}

struct CardIconAndName: View {
    var type: ActivtyCardType
    var icon: String
    var name: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .leading)
                .cornerRadius(15)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
            Text(name)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(type == .Friend ? .pink : .white)
        }
    }
}

enum ActivtyCardType: Int {
    case Friend
    case Community
}

extension ActivityCardView {
    
}

struct ActivityCardView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCardView(type: .Community, icon: "unicorn", name: "Unicorn", message: "Your friend just explored a new route! ", messageAge: 2)
    }
}
