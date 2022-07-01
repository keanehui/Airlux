//
//  AddFrdView.swift
//  Airlux
//
//  Created by Keane Hui on 2/7/2022.
//

import SwiftUI

struct AddFrdView: View {
    @Binding var content: MenuButtonType
    @Binding var isDrawerUp: Bool
    @Binding var isSheetUp: Bool
    
    var isShortCut: Bool = false
    
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
                            .padding(.bottom, person.firstName == "Seal" ? 80 : 0)
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
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

struct AddFrdView_Previews: PreviewProvider {
    static var previews: some View {
        AddFrdView(content: .constant(.AddFrd), isDrawerUp: .constant(false), isSheetUp: .constant(true))
    }
}
