//
//  SWPerson.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 31/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct SWPerson {
    let name: String?
    let gender: String?
    let species: [String]?
    let skinColor: String?
    let homePlanet: String?
    let vehicles: [String]?
    
    private enum CodingKeys: String,CodingKey {
        case name
        case gender
        case species
        case skinColor = "skin_color"
        case homePlanet = "homeworld"
        case vehicles
    }
}
extension SWPerson: Decodable {
    init(decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        species = try values.decodeIfPresent([String].self, forKey: .species)
        skinColor = try values.decodeIfPresent(String.self, forKey: .skinColor)
        homePlanet = try values.decodeIfPresent(String.self, forKey: .homePlanet)
        vehicles = try values.decodeIfPresent([String].self, forKey: .vehicles)
    }
}
