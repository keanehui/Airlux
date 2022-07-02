//
//  FriendListView.swift
//  Airlux
//
//  Created by Keane Hui on 1/7/2022.
//

import SwiftUI

struct FriendListView: View {
    @Binding var content: MenuButtonType
    @Binding var isDrawerUp: Bool
    @Binding var isSheetUp: Bool
    var isShortCut = false
    
    let me = Person.me
    let friends = Person.friends
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                Text("\(friends.count) friends")
                    .foregroundColor(.gray)
                ContactCard(icon: me.icon, firstName: me.firstName, lastName: me.lastName.uppercased(), opacity: 1.0)
                    .overlay(alignment: .topTrailing, content: {
                        VStack {
                            Text("\(me.AQI)")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.white)
                                .overlay(alignment: .trailing) {
                                    Circle()
                                        .fill(me.AQIColor)
                                        .frame(width: 8)
                                        .overlay(Circle().stroke(Color.white, lineWidth: 0.5))
                                        .offset(x: 10)
                                }
                            Text("avg. AQI")
                                .font(.caption2)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                        .padding(.top, 50)
                    })
                    .overlay(alignment: .trailing) {
                        Text("me")
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .foregroundColor(.gray.opacity(0.7))
                            .padding(.trailing)
                            .offset(y: 30)
                    }
                ForEach(friends, id: \.id) { friend in
                    ContactCard(icon: friend.icon, firstName: friend.firstName, lastName: friend.lastName.uppercased())
                    .padding(.bottom, friend.firstName == "Fish" ? 80 : 0)
                    .overlay(alignment: .topTrailing) {
                        VStack {
                            Text("\(friend.AQI)")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.white)
                                .overlay(alignment: .trailing) {
                                    Circle()
                                        .fill(friend.AQIColor)
                                        .frame(width: 8)
                                        .overlay(Circle().stroke(Color.white, lineWidth: 0.5))
                                        .offset(x: 10)
                                }
                            Text("avg. AQI")
                                .font(.caption2)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                        .padding(.top, 50)
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(.white)
        .navigationTitle("My Friends")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            NavigationLink {
                AddFrdView(content: $content, isDrawerUp: $isDrawerUp, isSheetUp: $isSheetUp)
            } label: {
                Label("Add Friend", systemImage: "plus")
                    .padding(.horizontal)
            }
        }
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
        FriendListView(content: .constant(.Friends), isDrawerUp: .constant(false), isSheetUp: .constant(true))
    }
}
