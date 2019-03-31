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

        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = SWColorScheme.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: SWCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: SWCollectionViewCell.reuseIdentifier)
        self.view.addSubview(collectionView)
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
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SWCollectionViewCell.reuseIdentifier, for: indexPath) as! SWCollectionViewCell
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("é uq")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SWCollectionViewCell.reuseIdentifier, for: indexPath)
        let theAttributes:UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
        selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)
        
        let char = SWCharacter(name: "Luke Skywalker",
                               gender: "Luke Skywalker",
                               species: "Luke Skywalker",
                               skinColor: "Luke Skywalker",
                               homePlanet: "Luke Skywalker",
                               vehicles: ["Luke Skywalker","Bla"])
        self.navigationController?.pushViewController(SWCharDetailsViewController(character: char), animated: true)
    }
}
