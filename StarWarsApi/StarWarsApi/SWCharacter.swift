//
//  SWCharacter.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 31/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct SWCharacter {
    let name: String
    let gender: String
    let species: String
    let skinColor: String
    let homePlanet: String
    let vehicles: [String]
    
    func getAttributedDescription() -> NSAttributedString {
        return NSAttributedString(string: "Name: " + self.name + "\nGender: " + self.gender + "\nSpecie: " + self.species + "\nSkin Color: " + self.skinColor + "\nHome Planet: " + self.homePlanet + "\nVehicles: " + self.vehicles.joined(separator: ","))
    }
}
