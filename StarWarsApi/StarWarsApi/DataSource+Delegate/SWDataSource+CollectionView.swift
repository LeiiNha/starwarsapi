//
//  SWDataSource+CollectionView.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 31/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation
import UIKit
class SWDataSource: NSObject, UICollectionViewDataSource {
    private let networkManager = NetworkManager()
    private let delegate: SWDelegate
    private let initialPage = 1
    
    private(set) var currentPage = 1
    private(set) var swPeople: [SWPerson] = []
    private(set) var nextPage: String? = "2"
    private(set) var swSpecies: [SWSpecie] = []
    private(set) var swVehicles: [SWVehicle] = []
    private(set) var swPlanets: [SWPlanet] = []
    
    init(delegate: SWDelegate) {
        self.delegate = delegate
        super.init()
        self.getPeople()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return swPeople.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SWCollectionViewCell.reuseIdentifier, for: indexPath) as? SWCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.nameLabel.text = swPeople[indexPath.row].name
        cell.charImage.tintColor = SWColorScheme.lightGray
        if let specie = swPeople[indexPath.row].species?.first {
            if let localSpecie = swSpecies.filter({ $0.url == specie }).first {
                self.delegate.updateCellObject(cell, localSpecie as AnyObject)
            } else {
                self.getSpecies(url: specie, completeCell: { specie in
                    self.delegate.updateCellObject(cell, specie as AnyObject)
                })
            }
        }
        if let vehicles = swPeople[indexPath.row].vehicles {
            cell.vehicleLabel.text = "Vehicles: \(vehicles.count)"
            vehicles.forEach { self.getVehicles(url: $0, completeCell: { vehicle in
                self.swVehicles.append(vehicle)
            }) }
        }
        if let planet = swPeople[indexPath.row].homePlanet {
            self.getPlanet(url: planet)
        }

        return cell
    }

    func updatePage() {
        guard nextPage != nil else { print("No more characters to be shown"); return }
        self.currentPage += 1
        self.getPeople()
    }
}

private extension SWDataSource {
    func getSpecies(url: String, completeCell: @escaping (SWSpecie) -> ()) {
        networkManager.getSpecies(url: url, completion: { specie, error in
            guard error == nil else { print(error ?? ""); return }
            guard let specie = specie else { return }
            self.swSpecies.append(specie)
            completeCell(specie)
        })
    }
    
    func getVehicles(url: String, completeCell: @escaping (SWVehicle) -> ()) {
        networkManager.getVehicles(url: url, completion: { vehicle, error in
            guard error == nil else { print(error ?? ""); return }
            guard let vehicle = vehicle else { return }
            self.swVehicles.append(vehicle)
            completeCell(vehicle)
        })
    }

    func getPeople() {
        networkManager.getPeople(page: currentPage, completion: { people, nextPage, error in
            print("Requesting page: " + self.currentPage.description)
            guard error == nil else { print(error ?? ""); return }
            guard let people = people else { return }
            
            self.swPeople.append(contentsOf: people)
            self.nextPage = nextPage
            self.delegate.updateCollectionView()
        })
    }
    
    func getPlanet(url: String) {
        networkManager.getHomePlanet(url: url, completion: { planet, error in
            guard error == nil else { print(error ?? ""); return }
            guard let planet = planet else { return }
            self.swPlanets.append(planet)
        })
    }
}
