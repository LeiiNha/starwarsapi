//
//  StarWarsApi.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 31/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

public enum StarWarsApi {
    case allCharacters(page: Int)
    case character(id: Int)
    case vehicle(id: Int)
    case specie(id: Int)
    case homeworld(id: Int)
    case directUrl(url: URL)
}

extension StarWarsApi: EndpointType {
    var baseURL: URL {
        switch self {
        case .directUrl(let url):
            return url
        default:
            guard let url = URL(string: "https://swapi.co/api/") else { fatalError("Error in the url") }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .allCharacters:
            return "people"
        case .character(let id):
            return "people/\(id)"
        case .vehicle(let id):
            return "vehicles/\(id)"
        case .specie(let id):
            return "species/\(id)"
        case .homeworld(let id):
            return "planets/\(id)"
        case .directUrl:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .allCharacters(let page):
            return .requestParameters(bodyParameters: nil, urlParameters: ["page": page])
        default:
            return .request
        }
    }
    var headers: HTTPHeaders? {
        return nil
    }
}
