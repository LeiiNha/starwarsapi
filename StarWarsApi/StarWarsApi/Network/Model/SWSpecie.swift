//
//  SWSpecie.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 31/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct SWSpecie {
    let name: String?
    let homePlanet: String?
    
    private enum CodingKeys: String,CodingKey {
        case name
        case homePlanet = "homeworld"
    }
}

extension SWSpecie: Decodable {
    init(decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        homePlanet = try values.decodeIfPresent(String.self, forKey: .homePlanet)
    }
}
