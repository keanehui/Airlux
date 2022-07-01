//
//  AddFrdView.swift
//  Airlux
//
//  Created by Keane Hui on 2/7/2022.
//

import SwiftUI

struct AddFrdView: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            TextField("Search to add a new friend", text: $text)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .disabled(true)
            Text("People You Might Know")
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            ScrollView(.vertical) {
                ForEach(Person.peopleYouMightKnow, id: \.id) { person in
                    if person.firstName.lowercased() == "fox" {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(.clear)
                            .frame(height: 10)
                        ContactCard(icon: person.icon, firstName: person.firstName, lastName: person.lastName.uppercased(), isFox: true)
                            .overlay(alignment: .trailing) {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "plus")
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(.blue)
                                        .padding()
                                }
                            }
                    } else {
                        ContactCard(icon: person.icon, firstName: person.firstName, lastName: person.lastName.uppercased())
                            .overlay(alignment: .trailing) {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "plus")
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(.blue)
                                        .padding()
                                }
                            }
                    }
                    
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct AddFrdView_Previews: PreviewProvider {
    static var previews: some View {
        AddFrdView()
    }
}
