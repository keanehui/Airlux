//
//  FriendListView.swift
//  Airlux
//
//  Created by Keane Hui on 1/7/2022.
//

import SwiftUI

struct FriendListView: View {
    let me = Person.me
    let friends = Person.friends
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Label("Back", systemImage: "lessthan")
                        .padding([.leading, .bottom])
                }
                Spacer()
            }
            HStack(spacing: 80) {
                Text("\(friends.count) friends")
                    .foregroundColor(.gray)
                    .bold()
                Button {
                    // send add friend request
                } label: {
                    Label("Add Friend", systemImage: "plus")
                }
            }
            ScrollView(.vertical) {
                ContactCard(icon: me.icon, firstName: me.firstName, lastName: me.lastName.uppercased(), opacity: 1.0)
                    .overlay(alignment: .trailing) {
                        Text("me")
                            .font(.system(size: 25, weight: .regular, design: .rounded))
                            .foregroundColor(.gray)
                            .padding(.trailing)
                    }
                ForEach(friends, id: \.id) { friend in
                    if friend.firstName.lowercased() == "fox" {
                        ContactCard(icon: friend.icon, firstName: friend.firstName, lastName: friend.lastName.uppercased(), isFox: true)
                    } else {
                        ContactCard(icon: friend.icon, firstName: friend.firstName, lastName: friend.lastName.uppercased())
                    }
                    
                }
            }
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
    }
}

struct ContactCard: View {
    var icon: String
    var firstName: String
    var lastName: String
    var color: Color = .orange
    var opacity: Double = 0.7
    var isFox: Bool = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(color.opacity(opacity))
                .frame(maxWidth: .infinity, maxHeight: 100)
            HStack(spacing: 10) {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(15)
                    .shadow(color: .gray.opacity(0.5), radius: 10)
                    .padding(.horizontal)
                    .offset(x: 0, y: -20)
                Spacer()
                VStack(alignment: .leading) {
                    Text(firstName)
                        .font(.title)
                    Text(lastName.uppercased())
                        .font(isFox ? .footnote : .title2)
                        .bold()
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
        }
        .padding(.vertical, 20)
    }
}

struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
//        ContactCard(icon: Person.friends[0].icon, firstName: Person.friends[0].firstName, lastName: Person.friends[0].lastName.uppercased())
        FriendListView()
    }
}
