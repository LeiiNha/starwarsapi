//
//  ViewController.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 30/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

class SWCharactersViewController: UIViewController {
    var selectedFrame: CGRect?
    var collectionView: UICollectionView?
    var dataSource: SWDataSource?
    
    let reloadBefore = 4
    
    var flowLayout: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()
        
        _flowLayout.itemSize = CGSize(width: 160, height: 150)
        _flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        _flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        _flowLayout.minimumInteritemSpacing = 0.0
        
        return _flowLayout
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureDataSource()
        self.configureCollectionView()
    }
    private func configureDataSource() {
        dataSource = SWDataSource(delegate: self)
    }
    
    private func configureCollectionView() {
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        guard let collectionView = self.collectionView else { fatalError("Could not init collectionView ") }
        collectionView.backgroundColor = SWColorScheme.white
        collectionView.delegate = self
        collectionView.dataSource = self.dataSource
        collectionView.register(UINib(nibName: SWCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: SWCollectionViewCell.reuseIdentifier)
        self.view.addSubview(collectionView)
    }
}

extension SWCharactersViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let frame = self.selectedFrame else { return nil }
        
        switch operation {
        case .push:
            return SWCustomAnimator(duration: 0.5, isPresenting: true, originFrame: frame)
        default:
            return SWCustomAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: false, originFrame: frame)
        }
    }
}

extension SWCharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let swPeople = self.dataSource?.swPeople else { return }
        if indexPath.row == swPeople.count - reloadBefore {
            self.dataSource?.updatePage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let theAttributes:UICollectionViewLayoutAttributes = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)
        guard let swPeople = self.dataSource?.swPeople else { return }
        let char = swPeople[indexPath.row]
        var vehicles: [SWVehicle] = []
        if let vehiclesUrls = char.vehicles {
            vehiclesUrls.forEach({ vehicleUrl in
                if let vehicle = self.dataSource?.swVehicles.filter({$0.url == vehicleUrl}).first {
                    vehicles.append(vehicle)
                }
            })
        }
        let planet = self.dataSource?.swPlanets.filter({ $0.url == char.homePlanet}).first
        let specie = self.dataSource?.swSpecies.filter({ $0.url == char.species?.first }).first
        self.navigationController?.pushViewController(SWCharDetailsViewController(person: char, vehicles: vehicles, specie: specie, planet: planet), animated: true)
    }
}

extension SWCharactersViewController: SWDelegate {
    func updateCellObject(_ cell: SWCollectionViewCell, _ obj: AnyObject) {
        switch obj {
        case is SWVehicle:
            if let obj = (obj as? SWVehicle), let name = obj.name {
                DispatchQueue.main.async { cell.vehicleLabel.text?.append(name + "\n") }
            }
        case is SWSpecie:
            if let obj = (obj as? SWSpecie), let name = obj.name {
                DispatchQueue.main.async { cell.speciesLabel.text = name }
            }
        default:
            return
        }
    }
    
    func updateCollectionView() {
        DispatchQueue.main.async { self.collectionView?.reloadData() }
    }
}
