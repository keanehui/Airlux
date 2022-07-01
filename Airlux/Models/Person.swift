//
//  Person.swift
//  Airlux
//
//  Created by Keane Hui on 1/7/2022.
//

import Foundation

struct Person: Identifiable {
    var icon: String
    var firstName: String
    var lastName: String
    var id: UUID = UUID()
}

extension Person {
    
    static let me: Person = Person(icon: "cat meow", firstName: "Cat", lastName: "Meow")
    
    static let friends: [Person] = [
        Person(icon: "bird tweet", firstName: "Bird", lastName: "Tweet"),
        Person(icon: "cow moo", firstName: "Cow", lastName: "Moo"),
        Person(icon: "dog woof", firstName: "Dog", lastName: "Woof"),
        Person(icon: "duck quack", firstName: "Duck", lastName: "Quack"),
        Person(icon: "elephant toot", firstName: "Elephant", lastName: "Toot"),
        Person(icon: "fish blub", firstName: "Fish", lastName: "Blub")
    ]
    
    static let peopleYouMightKnow: [Person] = [
        Person(icon: "fox ring-ding-ding-ding-dingeringeding", firstName: "Fox", lastName: "Ring-ding-ding-ding-dingeringeding"),
        Person(icon: "frog croak", firstName: "Frog", lastName: "Croak"),
        Person(icon: "mouse squeek", firstName: "Mouse", lastName: "Squeek"),
        Person(icon: "seal owowow", firstName: "Seal", lastName: "Owowow")
    ]
}
