//
//  AQIView.swift
//  Airlux
//
//  Created by Keane Hui on 29/6/2022.
//

import SwiftUI

struct CommunityView: View {
    @Binding var content: MenuButtonType
    @Binding var isDrawerUp: Bool
    @Binding var isSheetUp: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                communityHeader
                ScrollView {
                    myProfile
                    customDivider
                        .padding(.top, 5)
                    timeline
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .navigationBarHidden(true)
        }
        
        
    }
}

extension CommunityView {
    
    private var communityHeader: some View {
        HStack {
            Text("Community")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer()
            Button {
                withAnimation {
                    isSheetUp = false
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
    
    private var timeline: some View {
        VStack {
            Group {
                ActivityCardView(type: .Community, icon: "mappinAndCircle", name: "Mong Kok", message: "This route is popular among the Community.  ")
                ActivityCardView(type: .Friend, icon: "dog woof", name: "Dog", message: "Your friend just explored a new route! ")

                ActivityCardView(type: .Community, icon: "mappinAndCircle", name: "Mong Kok", message: "This route is popular among the Community.  ")
                ActivityCardView(type: .Friend, icon: "dog woof", name: "Dog", message: "Your friend just explored a new route! ")

                ActivityCardView(type: .Community, icon: "mappinAndCircle", name: "Mong Kok", message: "This route is popular among the Community.  ")
                ActivityCardView(type: .Friend, icon: "dog woof", name: "Dog", message: "Your friend just explored a new route! ")

                ActivityCardView(type: .Community, icon: "mappinAndCircle", name: "Mong Kok", message: "This route is popular among the Community.  ")
                ActivityCardView(type: .Friend, icon: "dog woof", name: "Dog", message: "Your friend just explored a new route! ")

                ActivityCardView(type: .Community, icon: "mappinAndCircle", name: "Mong Kok", message: "This route is popular among the Community.  ")
                ActivityCardView(type: .Friend, icon: "dog woof", name: "Dog", message: "Your friend just explored a new route! ")
            }
        }
    }
    
    private var customDivider: some View {
        HStack {
            RoundedRectangle(cornerRadius: 0)
                .frame(maxHeight: 2)
                .foregroundColor(.gray.opacity(0.5))
            Text("Timeline")
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .padding(.horizontal, 10)
            RoundedRectangle(cornerRadius: 0)
                .frame(maxHeight: 2)
                .foregroundColor(.gray.opacity(0.5))
        }
    }
    
    private var myProfile: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: 0.96, green: 0.96, blue: 0.96))      
            HStack(spacing: 30) {
                profileIconAndName
                VStack {
                    statistics
                    NavigationLink {
                        FriendListView()
                    } label: {
                        Text("My Friends: 10")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .padding(10)
                        .background(Color(red: 0.69, green: 0.61, blue: 0.85))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    }

                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: 180)
        
    }
    
    private var profileIconAndName: some View {
        VStack(spacing: 25) {
            Image(Person.me.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80, alignment: .leading)
                .cornerRadius(15)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
            Text(Person.me.firstName)
                .font(.system(size: 23, weight: .bold, design: .rounded))
                .foregroundColor(.orange)
        }
    }
    
    private var statistics: some View {
        VStack(alignment: .center, spacing: 10) {
            (Text("Statistics for ")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.gray.opacity(0.5))
             + Text("June")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.69, green: 0.61, blue: 0.85))
            )
            HStack(spacing: 20) {
                VStack {
                    Text("8")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.69, green: 0.61, blue: 0.85))
                        .bold()
                    Text("routes")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray.opacity(0.5))
                }
                VStack {
                    Text("193")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.69, green: 0.61, blue: 0.85))
                        .bold()
                    Text("km")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray.opacity(0.5))
                }
                VStack {
                    Text("42")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.69, green: 0.61, blue: 0.85))
                        .bold()
                    Text("avg. AQI")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray.opacity(0.5))
                }
            }
        }
    }
    
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView(content: .constant(.Community), isDrawerUp: .constant(true), isSheetUp: .constant(true))
    }
}
