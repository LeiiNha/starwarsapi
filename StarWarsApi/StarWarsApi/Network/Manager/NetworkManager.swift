//
//  NetworkManager.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 31/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct NetworkManager {
    private let router = Router<StarWarsApi>()
    
    enum NetworkResponse: String {
        case success
        case badRequest = "bad request"
        case failed = "request failed"
        case noData = "response with no data"
        case unableToDecode = "Could not decode"
        case networkFail = "Check your connection"
    }
    
    enum Result<String> {
        case success
        case failure(String)
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func getPeople(page: Int, completion: @escaping (_ people: [SWPerson]?, _ nextPage: String?, _ error: String?) -> ()) {
        router.request(.allCharacters(page: page)) { data, response, error in
            guard error == nil else { completion(nil, nil, NetworkResponse.networkFail.rawValue); return }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else { completion(nil, nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(SWPeopleResponse.self, from: responseData)
                        completion(apiResponse.results, apiResponse.next, nil)
                    } catch {
                        completion(nil, nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, nil, error)
                }
            }
        }
    }
    
    func getSpecies(url: String, completion: @escaping(_ species: SWSpecie?, _ error: String?) -> ()) {
        guard let url = URL(string: url) else { completion(nil, "Error in url"); return }
        router.request(.directUrl(url: url), completion: { data, response, error in
            guard error == nil else { completion(nil, NetworkResponse.networkFail.rawValue); return }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else { completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(SWSpecie.self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        })
    }
    
    func getVehicles(url: String, completion: @escaping(_ species: SWVehicle?, _ error: String?) -> ()) {
        guard let url = URL(string: url) else { completion(nil, "Error in url"); return }
        router.request(.directUrl(url: url), completion: { data, response, error in
            guard error == nil else { completion(nil, NetworkResponse.networkFail.rawValue); return }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else { completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(SWVehicle.self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        })
    }
    func getHomePlanet(url: String, completion: @escaping(_ species: SWPlanet?, _ error: String?) -> ()) {
        guard let url = URL(string: url) else { completion(nil, "Error in url"); return }
        router.request(.directUrl(url: url), completion: { data, response, error in
            guard error == nil else { completion(nil, NetworkResponse.networkFail.rawValue); return }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else { completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(SWPlanet.self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        })
    }
}
