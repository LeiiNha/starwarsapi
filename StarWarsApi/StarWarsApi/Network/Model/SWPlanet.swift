//
//  SWPlanet.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 31/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct SWPlanet {
    let name: String?
    let url: String?

    private enum CodingKeys: String,CodingKey {
        case name
        case url
    }
}

extension SWPlanet: Decodable {
    init(decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}
