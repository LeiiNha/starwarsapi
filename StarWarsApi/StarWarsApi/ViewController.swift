//
//  ViewController.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 30/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var selectedFrame: CGRect?
    var swPeople: [SWPerson]?
    var collectionView: UICollectionView?
    var currentPage = 1
    var nextPage: String? = "2"
    var respectiveImage: [Int] = []
    let networkManager = NetworkManager()
    
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

        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        guard let collectionView = self.collectionView else { fatalError("Could not init collectionView ") }
        collectionView.backgroundColor = SWColorScheme.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: SWCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: SWCollectionViewCell.reuseIdentifier)
        self.view.addSubview(collectionView)
        self.getPeople()
    }
    
    func getPeople() {
        if nextPage == nil {
            print("No more characters to be shown")
            return
        }
        networkManager.getPeople(page: currentPage, completion: { people, nextPage, error in
            print("Requesting page: " + self.currentPage.description)
            if let error = error {
                print(error)
            }
            if let people = people {
                if self.currentPage == 1 { self.swPeople = people } else { self.swPeople?.append(contentsOf: people)}
                self.nextPage = nextPage
                DispatchQueue.main.async { self.collectionView?.reloadData() }
            }
        })
    }
    func getSpecies(url: String, completeCell: @escaping (String) -> ()) {
        networkManager.getSpecies(url: url, completion: { specie, error in
            if let error = error {
                print(error)
            }
            if let specie = specie {
                completeCell(specie.name ?? "Unknown")
            }
        })
    }
}

extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let frame = self.selectedFrame else { return nil }
        
        switch operation {
        case .push:
            return SWCustomAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: true, originFrame: frame)
        default:
            return SWCustomAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: false, originFrame: frame)
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let swPeople = self.swPeople else { return 0 }
        return swPeople.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SWCollectionViewCell.reuseIdentifier, for: indexPath) as! SWCollectionViewCell
        //TODO: Fix this code
        guard let swPeople = self.swPeople else { return cell }
        cell.nameLabel.text = swPeople[indexPath.row].name
        swPeople[indexPath.row].species?.forEach {
            self.getSpecies(url: $0, completeCell: { specieName in
                DispatchQueue.main.async { cell.speciesLabel.text = specieName }
            })
        }
        cell.vehicleLabel.text = swPeople[indexPath.row].vehicles?.count.description
        
        cell.charImage.tintColor = SWColorScheme.whiteSmoke
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let swPeople = self.swPeople else { return }
        if indexPath.row == swPeople.count - 4 {
            currentPage += 1
            self.getPeople()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theAttributes:UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
        selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)
        guard let swPeople = self.swPeople else { return }
        let char = swPeople[indexPath.row]
        self.navigationController?.pushViewController(SWCharDetailsViewController(character: char), animated: true)
    }
}
