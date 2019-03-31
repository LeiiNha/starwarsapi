//
//  SWCollectionViewCell.swift
//  StarWarsApi
//
//  Created by Erica Geraldes on 30/03/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

class SWCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var charImage: UIImageView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var vehicleLabel: UILabel!
    
    static var reuseIdentifier: String = "SWCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        let layoutGuide = contentView.layoutMarginsGuide
        
        outerView.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor).isActive = true
        outerView.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor).isActive = true
        outerView.widthAnchor.constraint(equalToConstant: 150.0)
        
        detailView.centerXAnchor.constraint(equalTo: outerView.centerXAnchor).isActive = true
        detailView.centerYAnchor.constraint(equalTo: outerView.centerYAnchor).isActive = true
        detailView.widthAnchor.constraint(equalToConstant: 144.0)
        
        
        charImage.translatesAutoresizingMaskIntoConstraints = false
        charImage.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 10).isActive = true
        charImage.centerXAnchor.constraint(equalTo: detailView.centerXAnchor).isActive = true
        charImage.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        charImage.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

        setAnchors(to: nameLabel, equalTo: detailView, topConstant: 50)
        setAnchors(to: speciesLabel, equalTo: nameLabel, topConstant: 20)
        setAnchors(to: vehicleLabel, equalTo: speciesLabel, topConstant: 20)
        
        //TODO: Fix some images not showing
        //charImage.image = UIImage(named: Int.random(in: 1..<12).description)?.withRenderingMode(.alwaysTemplate)
        
    }
    
    private func setAnchors(to label: UILabel, equalTo view: UIView, topConstant: CGFloat) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        label.textAlignment = .center
    }

}
