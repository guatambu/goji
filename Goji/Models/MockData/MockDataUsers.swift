//
//  MockDataUsers.swift
//  Goji
//
//  Created by Michael Guatambu Davis on 6/13/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//


import UIKit

class MockDataUsers {
    
    // Users
    static let maggie = User(uid: "01", email: "maggie@email.com", username: "TotsMcGoats", password: "password", isPrivate: true, firstName: "Margaret", lastName: "Thompson", mockProfilePic: UIImage(named: "maggie"), location: "earth", age: "30")
    
    static let rodrigo = User(uid: "02", email: "rodrigo@email.com", username: "rodrigo31", password: "password", isPrivate: false, firstName: "Rodrigo", lastName: "Santoro", mockProfilePic: UIImage(named: "rodrigo"), location: "Venezuela", age: "19")
    
    static let dylon = User(uid: "03", email: "dylon@email.com", username: "dylonjefferson", password: "password", isPrivate: true, firstName: "Dylon", lastName: "Jefferson", mockProfilePic: UIImage(named: "dylon"), location: "Washington", age: "25")
    
    static let luisa = User(uid: "04", email: "luisa@email.com", username: "luluu", password: "password", isPrivate: false, firstName: "Luisa", lastName: "Morães da Silva", mockProfilePic: UIImage(named: "luisa"), location: "São Paulo, São Paulo, Brasil", age: "35")
    
    static let park = User(uid: "05", email: "park@email.com", username: "parkhan", password: "password", isPrivate: true, firstName: "Park", lastName: "Han", mockProfilePic: UIImage(named: "park"), location: "Tokyo, Japan", age: "40")
    
    static let sangita = User(uid: "06", email: "sangita@email.com", username: "sangiji", password: "password", isPrivate: false, firstName: "Sangita", lastName: "Chaudry", mockProfilePic: UIImage(named: "sangita"), location: "London, England, UK", age: "51")
    
    static let sam = User(uid: "07", email: "sam@email.com", username: "sam01", password: "password", isPrivate: false, firstName: "Sam", lastName: "Russo", mockProfilePic: UIImage(named: "samantha"), location: "Seattle, Washington", age: "26", bioBlurb: "Working toward her dream job in Seattle.  She lives with roomates and just got done with college at UW.")
    
    
    static let allOtherUsers = [MockDataUsers.park, MockDataUsers.dylon, MockDataUsers.luisa, MockDataUsers.maggie, MockDataUsers.rodrigo, MockDataUsers.sangita]
}













